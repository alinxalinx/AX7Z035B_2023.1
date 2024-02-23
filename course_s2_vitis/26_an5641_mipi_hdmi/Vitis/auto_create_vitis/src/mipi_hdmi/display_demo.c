
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
#include "xgpiops.h"
#include "xgpio.h"
#include "sleep.h"
#include "ov5640.h"
#include "config.h"
#include "demosaic.h"
#include "gamma_lut.h"
#include "xcsi.h"

/*
 * XPAR redefines
 */
#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define VGA_VDMA_ID XPAR_AXIVDMA_1_DEVICE_ID
#define DISP_VTC_ID XPAR_VTC_0_DEVICE_ID

#if P1080 == 1
#define HORSIZE 1920*3
#define VERSIZE 1080
#else
#define HORSIZE 1280*3
#define VERSIZE 720
#endif

#define CAM_EMIO	54

#define LED_DEVICE_ID XPAR_AXI_GPIO_0_DEVICE_ID

#define LED_CHANNEL 1
/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */

/*
 * Display Driver structs
 */
XGpio Gpio_led ;
XIicPs ps_i2c0;
XIicPs ps_i2c1;
XGpioPs Gpio;
XCsi mipiCsi ;
/*
 * Display Driver structs
 */
DisplayCtrl dispCtrl;
XAxiVdma vdma;
/*
 * Framebuffers for video data
 */
u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME] __attribute__ ((aligned(256)));
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers

void adv7511_init(XIicPs *IicInstance) ;
int PsGpioSetup() ;
int PLGpioSetup() ;

int main(void)
{

	int Status;
	int i ;
	XAxiVdma_Config *vdmaConfig;

	XCsi_Config *csiConfig ;
	u32 frameCountLast ;
	u32 frameCountCurr ;
	u32 crcErrorCount ;


	/*
	 * Initialize an array of pointers to the 3 frame buffers
	 */
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++)
	{
		pFrames[i] = frameBuf[i];
		memset(pFrames[i], 0, DEMO_MAX_FRAME);
		Xil_DCacheFlushRange((INTPTR) pFrames[i], DEMO_MAX_FRAME) ;
	}

	i2c_init(&ps_i2c1, XPAR_XIICPS_1_DEVICE_ID,100000);

	adv7511_init(&ps_i2c1) ;
	csiConfig = XCsi_LookupConfig(XPAR_MIPI_CSI2_RX_SUBSYST_0_RX_DEVICE_ID);

	Status = XCsi_CfgInitialize(&mipiCsi, csiConfig, 0x43c00000);
	if (Status != XST_SUCCESS) {
		xil_printf("Csi subsystem initial Failed\r\n");
		return XST_FAILURE;
	}


	PsGpioSetup() ;
	PLGpioSetup() ;
	/*
	 * Reset sensor
	 */
	XGpioPs_WritePin(&Gpio, CAM_EMIO, 0) ;
	usleep(1000000);
	XGpioPs_WritePin(&Gpio, CAM_EMIO, 1) ;
	usleep(1000000);

	i2c_init(&ps_i2c0, XPAR_XIICPS_0_DEVICE_ID,100000);


	/*
	 * Initialize VDMA driver
	 */
	vdmaConfig = XAxiVdma_LookupConfig(VGA_VDMA_ID);
	if (!vdmaConfig)
	{
		xil_printf("No video DMA found for ID %d\r\n", VGA_VDMA_ID);

	}
	Status = XAxiVdma_CfgInitialize(&vdma, vdmaConfig, vdmaConfig->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		xil_printf("VDMA Configuration Initialization failed %d\r\n", Status);

	}

	/*
	 * Initialize the Display controller and start it
	 */
	Status = DisplayInitialize(&dispCtrl, &vdma, DISP_VTC_ID, DYNCLK_BASEADDR,pFrames, DEMO_STRIDE);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Display Ctrl initialization failed during demo initialization%d\r\n", Status);

	}
	Status = DisplayStart(&dispCtrl);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Couldn't start display during demo initialization%d\r\n", Status);

	}

	gamma_lut_init();
	demosaic_init();

	/* Start Sensor Vdma */
	vdma_write_init(XPAR_AXIVDMA_0_DEVICE_ID,HORSIZE,VERSIZE,DEMO_STRIDE,(unsigned int)pFrames[0]);

	/*
	 * Initialize Sensor
	 */
	sensor_init(&ps_i2c0);



	sleep(1) ;
	frameCountLast = XCsi_GetCurrentPacketCount(&mipiCsi) ;
	xil_printf("Frame counter is %d\r\n", frameCountLast);
	sleep(1) ;
	frameCountCurr = XCsi_GetCurrentPacketCount(&mipiCsi) ;
	xil_printf("Frame counter is %d\r\n", frameCountCurr);
	crcErrorCount = XCsi_GetBitField(mipiCsi.Config.BaseAddr, XCSI_ISR_OFFSET, XCSI_ISR_CRCERR_MASK, 9) ;
	xil_printf("crc value is %d\r\n", crcErrorCount);


	while(1)
	{
		if (frameCountCurr != frameCountLast && crcErrorCount == 0)
		{
			/* Set the LED to High */
			XGpio_DiscreteWrite(&Gpio_led, LED_CHANNEL, 0);
			usleep(200000) ;
			XGpio_DiscreteWrite(&Gpio_led, LED_CHANNEL, 0x3);
			usleep(200000) ;
		}
		else
		{
			frameCountLast = frameCountCurr ;
			frameCountCurr =XCsi_GetCurrentPacketCount(&mipiCsi) ;
			crcErrorCount = XCsi_GetBitField(mipiCsi.Config.BaseAddr, XCSI_ISR_OFFSET, XCSI_ISR_CRCERR_MASK, 9) ;
			/* Set the LED to High */
			XGpio_DiscreteWrite(&Gpio_led, LED_CHANNEL, 0);
			usleep(200000) ;
			XGpio_DiscreteWrite(&Gpio_led, LED_CHANNEL, 1);
			usleep(200000) ;
		}
	}

	return 0;
}



int PsGpioSetup()
{
	XGpioPs_Config *GPIO_CONFIG ;
	int Status ;

	GPIO_CONFIG = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID) ;

	Status = XGpioPs_CfgInitialize(&Gpio, GPIO_CONFIG, GPIO_CONFIG->BaseAddr) ;
	if (Status != XST_SUCCESS)
	{
		return XST_FAILURE ;
	}
	/* set MIO 54 as output */
	XGpioPs_SetDirectionPin(&Gpio, CAM_EMIO, 1) ;

	XGpioPs_SetOutputEnablePin(&Gpio, CAM_EMIO, 1);


	return XST_SUCCESS ;
}

int PLGpioSetup()
{
	int Status ;

	/* initial gpio led */
	Status = XGpio_Initialize(&Gpio_led, LED_DEVICE_ID) ;
	if (Status != XST_SUCCESS)
		return XST_FAILURE ;

	/* set led as output */
	XGpio_SetDataDirection(&Gpio_led, LED_CHANNEL, 0x0);

	return XST_SUCCESS ;
}
