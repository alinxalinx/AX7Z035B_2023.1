/************************************************************************/
/*																		*/
/*	display_demo.c	--	ALINX AX7010 HDMI Display demonstration 						*/
/*																		*/
/************************************************************************/

/* ------------------------------------------------------------ */
/*				Include File Definitions						*/
/* ------------------------------------------------------------ */

#include "display_demo.h"
#include "display_ctrl/display_ctrl.h"
#include <stdio.h>
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xiicps.h"
#include "vdma.h"
#include "i2c/PS_i2c.h"
#include "xgpio.h"
#include "sleep.h"
#include "ov5640.h"
#include "xscugic.h"
#include "zynq_interrupt.h"
#include "xgpio.h"
#include "ff.h"
#include "bmp.h"
#include "xil_cache.h"
#include "xtime_l.h"
/*
 * XPAR redefines
 */
#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define DISPLAY_VDMA_ID XPAR_AXIVDMA_0_DEVICE_ID
#define DISP_VTC_ID XPAR_VTC_0_DEVICE_ID
#define VID_VTC_IRPT_ID XPS_FPGA3_INT_ID
#define VID_GPIO_IRPT_ID XPS_FPGA4_INT_ID
#define SCU_TIMER_ID XPAR_SCUTIMER_DEVICE_ID
#define UART_BASEADDR XPAR_PS7_UART_1_BASEADDR
#define CAME_VDMA_ID  XPAR_AXIVDMA_1_DEVICE_ID

#define S2MM_INTID XPAR_FABRIC_AXI_VDMA_1_S2MM_INTROUT_INTR
#define MM2S_INTID XPAR_FABRIC_AXI_VDMA_0_MM2S_INTROUT_INTR


/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */

/*
 * Display Driver structs
 */
DisplayCtrl dispCtrl;
XAxiVdma display_vdma;
XAxiVdma camera_vdma;
XIicPs ps_i2c0;
XGpio hdmi_rstn;
XGpio cmos_rstn;

XScuGic XScuGicInstance;


static FIL fil;		/* File object */
static FATFS fatfs;

static int WriteError;

int wr_index = 0;
int rd_index = 0;

/*
 * PL GPIO definitions
 */
#define KEY_DEVICE_ID   XPAR_AXI_GPIO_0_DEVICE_ID
#define LED_DEVICE_ID	 XPAR_AXI_GPIO_1_DEVICE_ID
#define KEY_INTR_ID 	XPAR_FABRIC_AXI_GPIO_0_IP2INTC_IRPT_INTR

#define LED_DIR 0x0f
#define LED_CHANNEL 1
#define KEY_DIR 0x0f
#define KEY_CHANNEL 1

#define BTN_INT             XGPIO_IR_CH1_MASK

XGpio Gpio_key ;
XGpio Gpio_led ;
volatile int key_flag = 0;
int KeyFlagHold = 1 ;

XTime TimerCurr, TimerLast;

/*
 * Framebuffers for video data
 */

u8 photobuf[DEMO_MAX_FRAME] ;

u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME] __attribute__ ((aligned(64)));
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers
unsigned char PhotoBuf[DEMO_MAX_FRAME] ;

/* ------------------------------------------------------------ */
/*				Procedure Definitions							*/
/* ------------------------------------------------------------ */

static void WriteCallBack(void *CallbackRef, u32 Mask);
static void WriteErrorCallBack(void *CallbackRef, u32 Mask);
static void ReadCallBack(void *CallbackRef, u32 Mask);

int PLGpioSetup(XScuGic *InstancePtr) ;
int PlGpioHandler(void *CallbackRef) ;


void adv7511_init(XIicPs *IicInstance) ;


int main(void)
{

	int Status;
	XAxiVdma_Config *vdmaConfig;
	int i;
	FRESULT rc;
	XTime TimerStart, TimerEnd;
	float elapsed_time ;
	unsigned int PhotoCount = 0 ;

	char PhotoName[9] ;

	/*
	 * Initialize an array of pointers to the 3 frame buffers
	 */
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++)
	{
		pFrames[i] = frameBuf[i];
		memset(pFrames[i], 0, DEMO_MAX_FRAME);
		Xil_DCacheFlushRange((INTPTR) pFrames[i], DEMO_MAX_FRAME) ;
	}

	/*
	 * Initial GIC
	 */
	InterruptInit(XPAR_SCUGIC_0_DEVICE_ID,&XScuGicInstance);

	i2c_init(&ps_i2c0, XPAR_XIICPS_0_DEVICE_ID,40000);
	XGpio_Initialize(&cmos_rstn, XPAR_CMOS_RST_DEVICE_ID);   //initialize GPIO IP
	XGpio_SetDataDirection(&cmos_rstn, 1, 0x0);            //set GPIO as output
	XGpio_DiscreteWrite(&cmos_rstn, 1, 0x1);
	usleep(500000);
	XGpio_DiscreteWrite(&cmos_rstn, 1, 0x0);               //set GPIO output value to 0

	usleep(500000);
	XGpio_DiscreteWrite(&cmos_rstn, 1, 0x3);
	usleep(500000);


	/*
	 * Initialize display port
	 */
	adv7511_init(&ps_i2c0) ;
	/*
	 * Initialize Sensor
	 */
	sensor_init(&ps_i2c0);

	/*
	 * Setup KEY and LED
	 */
	PLGpioSetup(&XScuGicInstance) ;

	/* Initial Camera Vdma */
	vdma_write_init(CAME_VDMA_ID, &camera_vdma, 1280 * 3, 720, DEMO_STRIDE,	(unsigned int)pFrames[0], DISPLAY_NUM_FRAMES);
	/* Set General Callback for Sensor Vdma */
	XAxiVdma_SetCallBack(&camera_vdma, XAXIVDMA_HANDLER_GENERAL,WriteCallBack, (void *)&camera_vdma, XAXIVDMA_WRITE);
	/* Set Error Callback for Sensor Vdma */
	XAxiVdma_SetCallBack(&camera_vdma, XAXIVDMA_HANDLER_ERROR,WriteErrorCallBack, (void *)&camera_vdma, XAXIVDMA_WRITE);
	/* Connect interrupt to GIC */
	InterruptConnect(&XScuGicInstance,S2MM_INTID,XAxiVdma_WriteIntrHandler,(void *)&camera_vdma);
	/* enable vdma interrupt */
	XAxiVdma_IntrEnable(&camera_vdma, XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_WRITE);

	/*
	 * Initialize Display VDMA driver
	 */
	vdmaConfig = XAxiVdma_LookupConfig(DISPLAY_VDMA_ID);
	if (!vdmaConfig)
	{
		xil_printf("No video DMA found for ID %d\r\n", DISPLAY_VDMA_ID);
	}
	Status = XAxiVdma_CfgInitialize(&display_vdma, vdmaConfig, vdmaConfig->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		xil_printf("VDMA Configuration Initialization failed %d\r\n", Status);

	}

	/*
	 * Initialize the Display controller and start it
	 */
	Status = DisplayInitialize(&dispCtrl, &display_vdma, DISP_VTC_ID, DYNCLK_BASEADDR,pFrames, DEMO_STRIDE);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Display Ctrl initialization failed during demo initialization%d\r\n", Status);

	}
	Status = DisplayStart(&dispCtrl);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Couldn't start display during demo initialization%d\r\n", Status);

	}
	/* Set General Callback for dispaly Vdma */
	XAxiVdma_SetCallBack(&display_vdma, XAXIVDMA_HANDLER_GENERAL,ReadCallBack, (void *)&display_vdma, XAXIVDMA_READ);
	/* Connect interrupt to GIC */
	InterruptConnect(&XScuGicInstance,MM2S_INTID,XAxiVdma_ReadIntrHandler,(void *)&display_vdma);
	/* enable vdma interrupt */
	XAxiVdma_IntrEnable(&display_vdma, XAXIVDMA_IXR_ALL_MASK, XAXIVDMA_READ);

	/* Set LED off */
	XGpio_DiscreteWrite(&Gpio_led, LED_CHANNEL, 0);

	rc = f_mount(&fatfs, "0:/", 0);
	if (rc != FR_OK)
	{
		return 0 ;
	}

	while(1)
	{
		if (key_flag == 2)
		{
			KeyFlagHold = 0;
			/*
			 * increment of photo name
			 */
			PhotoCount++ ;
			sprintf(PhotoName, "%04u.bmp", PhotoCount) ;

			/* Set LED on */
			XGpio_DiscreteWrite(&Gpio_led, LED_CHANNEL, 1);
			printf("Successfully Take Photo, Photo Name is %s\r\n", PhotoName) ;
			printf("Write to SD Card...\r\n") ;
			/*
			 * Set timer
			 */
			XTime_SetTime(0) ;
			XTime_GetTime(&TimerStart) ;

			Xil_DCacheInvalidateRange((unsigned int) pFrames[(wr_index+1)%3], DEMO_MAX_FRAME) ;
			/*
			 * Copy frame data to photo buffer
			 */
			memcpy(&photobuf, pFrames[(wr_index+1)%3],  DEMO_MAX_FRAME) ;

			/*
			 * Clear key flag
			 */
			key_flag = 0 ;
			/*
			 * Write to SD Card
			 */
			bmp_write(PhotoName, (char *)&BMODE_1280x720, (char *)&photobuf, DEMO_STRIDE, &fil) ;
			/*
			 * Print Elapsed time
			 */
			XTime_GetTime(&TimerEnd) ;
			elapsed_time = ((float)(TimerEnd-TimerStart))/((float)COUNTS_PER_SECOND) ;
			printf("INFO:Elapsed time = %.2f sec\r\n", elapsed_time) ;
		}
		/* Set LED off */
		XGpio_DiscreteWrite(&Gpio_led, LED_CHANNEL, 0);
		KeyFlagHold = 1;
	}


	return 0;
}

/*****************************************************************************/
/*
 * Call back function for write channel
 *
 * This callback only clears the interrupts and updates the transfer status.
 *
 * @param	CallbackRef is the call back reference pointer
 * @param	Mask is the interrupt mask passed in from the driver
 *
 * @return	None
 *
 ******************************************************************************/
static void WriteCallBack(void *CallbackRef, u32 Mask)
{
	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK)
	{

		if(key_flag == 1)
		{
			key_flag = 2 ;
			return;
		}
		else if(key_flag == 2)
		{
			return ;
		}

		if(wr_index==2)
		{
			wr_index=0;
			rd_index=2;
		}
		else
		{
			rd_index = wr_index;
			wr_index++;
		}
		/* Set park pointer */
		XAxiVdma_StartParking((XAxiVdma*)CallbackRef, wr_index, XAXIVDMA_WRITE);
	}
}


/*****************************************************************************/
/*
 * Call back function for write channel error interrupt
 *
 * @param	CallbackRef is the call back reference pointer
 * @param	Mask is the interrupt mask passed in from the driver
 *
 * @return	None
 *
 ******************************************************************************/
static void WriteErrorCallBack(void *CallbackRef, u32 Mask)
{

	if (Mask & XAXIVDMA_IXR_ERROR_MASK) {
		WriteError += 1;
	}
}


static void ReadCallBack(void *CallbackRef, u32 Mask)
{
	if (Mask & XAXIVDMA_IXR_FRMCNT_MASK)
	{
		/* Set park pointer */
		XAxiVdma_StartParking((XAxiVdma*)CallbackRef, rd_index, XAXIVDMA_READ);
	}
}


/*
 * Set up PL key and enable GPIO interrupt
 */
int PLGpioSetup(XScuGic *InstancePtr)
{
	int Status ;

	/* initial gpio key */
	Status = XGpio_Initialize(&Gpio_key, KEY_DEVICE_ID) ;
	if (Status != XST_SUCCESS)
		return XST_FAILURE ;

	/* initial gpio led */
	Status = XGpio_Initialize(&Gpio_led, LED_DEVICE_ID) ;
	if (Status != XST_SUCCESS)
		return XST_FAILURE ;

	/* set key as input */
	XGpio_SetDataDirection(&Gpio_key, KEY_CHANNEL, 0x1);
	/* set led as output */
	XGpio_SetDataDirection(&Gpio_led, LED_CHANNEL, 0x0);

	/* Enable key interrupt */
	XGpio_InterruptGlobalEnable(&Gpio_key) ;
	XGpio_InterruptEnable(&Gpio_key, BTN_INT) ;

	InterruptConnect(InstancePtr, KEY_INTR_ID, (void *)PlGpioHandler, (void *)&Gpio_key) ;

	return XST_SUCCESS ;
}



int PlGpioHandler(void *CallbackRef)
{
	XGpio *GpioInstancePtr = (XGpio *)CallbackRef ;
	int Int_val ;
	int key_val ;
	float Interval_time ;

	Int_val = XGpio_InterruptGetStatus(GpioInstancePtr);
	key_val = XGpio_DiscreteRead(GpioInstancePtr, KEY_CHANNEL) ;
	/* Clear Interrupt */
	XGpio_InterruptClear(GpioInstancePtr, XGPIO_IR_CH1_MASK) ;

	if (Int_val)
	{
		TimerLast = TimerCurr ;
		XTime_GetTime(&TimerCurr) ;
		Interval_time = ((float)(TimerCurr-TimerLast))/((float)COUNTS_PER_SECOND) ;
		/* Key debounce, set decounce time to 200ms*/
		if (Interval_time < 0.2)
		{
			key_flag = 0 ;
			return 0 ;
		}else
		{
			/* Key default value is high, check key pressed value*/
			if (key_val == 0)
				key_flag = 1 ;
		}
	}
	return 1 ;

}
