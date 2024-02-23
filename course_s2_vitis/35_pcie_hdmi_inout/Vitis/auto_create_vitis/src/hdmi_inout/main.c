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
#include "pic_800_600.h"
#include "i2c/PS_i2c.h"
#include "xgpio.h"
#include "sleep.h"
#include "vdma.h"
/*
 * XPAR redefines
 */
#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define VGA_VDMA_ID XPAR_AXIVDMA_0_DEVICE_ID
#define DISP_VTC_ID XPAR_VTC_0_DEVICE_ID
#define VID_VTC_IRPT_ID XPS_FPGA3_INT_ID
#define VID_GPIO_IRPT_ID XPS_FPGA4_INT_ID
#define SCU_TIMER_ID XPAR_SCUTIMER_DEVICE_ID
#define UART_BASEADDR XPAR_PS7_UART_1_BASEADDR

#define IMAGE_BASE (512 * 1024 * 1024 + 0x80000000)
/* ------------------------------------------------------------ */
/*				Global Variables								*/
/* ------------------------------------------------------------ */

/*
 * Display Driver structs
 */
DisplayCtrl dispCtrl;
XAxiVdma vdma;

/*
 * Framebuffers for video data
 */
u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME] __attribute__ ((aligned(64)));
u8 *pFrames[DISPLAY_NUM_FRAMES]; //array of pointers to the frame buffers

XIicPs IicInstance0;
XIicPs IicInstance1;
XGpio GpioOutput;
/* ------------------------------------------------------------ */
/*				Procedure Definitions							*/
/* ------------------------------------------------------------ */
void adv7511_init(unsigned int DeviceId) ;
void sil9011_init(unsigned int DeviceId) ;



int main(void) {

	int Status;
	XAxiVdma_Config *vdmaConfig;
	int i;

	/*
	 * Initialize an array of pointers to the 3 frame buffers
	 */
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++) {
		//pFrames[i] = frameBuf[i];
		pFrames[i] = (u8 *)IMAGE_BASE;
	}


	XGpio_Initialize(&GpioOutput, XPAR_GPIO_0_DEVICE_ID); //initialize GPIO IP
	XGpio_SetDataDirection(&GpioOutput, 1, 0x0);            //set GPIO as output
	XGpio_DiscreteWrite(&GpioOutput, 1, 0x0);       //set GPIO output value to 0
	usleep(50000);
	XGpio_DiscreteWrite(&GpioOutput, 1, 0x1);


	/*
	 * Initialize display port
	 */
	adv7511_init(XPAR_XIICPS_0_DEVICE_ID) ;

	sil9011_init(XPAR_XIICPS_1_DEVICE_ID) ;


	/*
	 * Initialize VDMA driver
	 */
	vdmaConfig = XAxiVdma_LookupConfig(VGA_VDMA_ID);
	if (!vdmaConfig) {
		xil_printf("No video DMA found for ID %d\r\n", VGA_VDMA_ID);

	}
	Status = XAxiVdma_CfgInitialize(&vdma, vdmaConfig, vdmaConfig->BaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("VDMA Configuration Initialization failed %d\r\n", Status);

	}

	/*
	 * Initialize the Display controller and start it
	 */
	Status = DisplayInitialize(&dispCtrl, &vdma, DISP_VTC_ID, DYNCLK_BASEADDR,
			pFrames, DEMO_STRIDE);
	if (Status != XST_SUCCESS) {
		xil_printf(
				"Display Ctrl initialization failed during demo initialization%d\r\n",
				Status);

	}
	Status = DisplayStart(&dispCtrl);
	if (Status != XST_SUCCESS) {
		xil_printf("Couldn't start display during demo initialization%d\r\n",
				Status);

	}

	DemoPrintTest(dispCtrl.framePtr[dispCtrl.curFrame], dispCtrl.vMode.width,
			dispCtrl.vMode.height, dispCtrl.stride, DEMO_PATTERN_2);
	vdma_write_init(XPAR_AXIVDMA_1_DEVICE_ID,1920 * 3,1080,1920 * 3,dispCtrl.framePtr[dispCtrl.curFrame]);

	return 0;
}

void DemoPrintTest(u8 *frame, u32 width, u32 height, u32 stride, int pattern) {
	u32 xcoi, ycoi;
	u32 iPixelAddr = 0;
	u8 wRed, wBlue, wGreen;
	u32 xInt;
	u32 pic_number = 0;

	switch (pattern) {
	case DEMO_PATTERN_0:

		for (ycoi = 0; ycoi < 600; ycoi++) {
			for (xcoi = 0; xcoi < (800 * 3); xcoi += 3) {
				frame[xcoi + iPixelAddr + 0] = gImage_pic_800_600[pic_number++];
				frame[xcoi + iPixelAddr + 1] = gImage_pic_800_600[pic_number++];
				frame[xcoi + iPixelAddr + 2] = gImage_pic_800_600[pic_number++];
			}
			iPixelAddr += stride;
		}
		/*
		 * Flush the framebuffer memory range to ensure changes are written to the
		 * actual memory, and therefore accessible by the VDMA.
		 */
		Xil_DCacheFlushRange((unsigned int) frame, DEMO_MAX_FRAME);
		break;
	case DEMO_PATTERN_1:         //Grid

		for (ycoi = 0; ycoi < height; ycoi++) {
			for (xcoi = 0; xcoi < (width * 3); xcoi += 3) {
				if (((xcoi / 4) & 0x20) ^ (ycoi & 0x20)) {
					wRed = 255;
					wGreen = 255;
					wBlue = 255;
				} else {
					wRed = 0;
					wGreen = 0;
					wBlue = 0;
				}

				frame[xcoi + iPixelAddr + 0] = wBlue;
				frame[xcoi + iPixelAddr + 1] = wGreen;
				frame[xcoi + iPixelAddr + 2] = wRed;
			}
			iPixelAddr += stride;
		}
		/*
		 * Flush the framebuffer memory range to ensure changes are written to the
		 * actual memory, and therefore accessible by the VDMA.
		 */
		Xil_DCacheFlushRange((unsigned int) frame, DEMO_MAX_FRAME);
		break;
	case DEMO_PATTERN_2:         //8 intervals color bar

		for (ycoi = 0; ycoi < height; ycoi++) {
			for (xcoi = 0; xcoi < (width * 3); xcoi += 3) {

				frame[xcoi + iPixelAddr + 0] = xcoi / 4;
				frame[xcoi + iPixelAddr + 1] = xcoi / 4;
				frame[xcoi + iPixelAddr + 2] = xcoi / 4;
			}
			iPixelAddr += stride;
		}
		/*
		 * Flush the framebuffer memory range to ensure changes are written to the
		 * actual memory, and therefore accessible by the VDMA.
		 */
		Xil_DCacheFlushRange((unsigned int) frame, DEMO_MAX_FRAME);
		break;
	case DEMO_PATTERN_3: //8 intervals color bar

		xInt = width * 3 / 8; //each with width/8 pixels

		for (ycoi = 0; ycoi < height; ycoi++) {

			/*
			 * Just draw white in the last partial interval (when width is not divisible by 7)
			 */

			for (xcoi = 0; xcoi < (width * 3); xcoi += 3) {

				if (xcoi < xInt) {                                 //White color
					wRed = 255;
					wGreen = 255;
					wBlue = 255;
				}

				else if ((xcoi >= xInt) && (xcoi < xInt * 2)) {   //YELLOW color
					wRed = 255;
					wGreen = 255;
					wBlue = 0;
				} else if ((xcoi >= xInt * 2) && (xcoi < xInt * 3)) { //CYAN color
					wRed = 0;
					wGreen = 255;
					wBlue = 255;
				} else if ((xcoi >= xInt * 3) && (xcoi < xInt * 4)) { //GREEN color
					wRed = 0;
					wGreen = 255;
					wBlue = 0;
				} else if ((xcoi >= xInt * 4) && (xcoi < xInt * 5)) { //MAGENTA color
					wRed = 255;
					wGreen = 0;
					wBlue = 255;
				} else if ((xcoi >= xInt * 5) && (xcoi < xInt * 6)) { //RED color
					wRed = 255;
					wGreen = 0;
					wBlue = 0;
				} else if ((xcoi >= xInt * 6) && (xcoi < xInt * 7)) { //BLUE color
					wRed = 0;
					wGreen = 0;
					wBlue = 255;
				} else {                                           //BLACK color
					wRed = 0;
					wGreen = 0;
					wBlue = 0;
				}

				frame[xcoi + iPixelAddr + 0] = wBlue;
				frame[xcoi + iPixelAddr + 1] = wGreen;
				frame[xcoi + iPixelAddr + 2] = wRed;
				/*
				 * This pattern is printed one vertical line at a time, so the address must be incremented
				 * by the stride instead of just 1.
				 */
			}
			iPixelAddr += stride;

		}
		/*
		 * Flush the framebuffer memory range to ensure changes are written to the
		 * actual memory, and therefore accessible by the VDMA.
		 */
		Xil_DCacheFlushRange((unsigned int) frame, DEMO_MAX_FRAME);
		break;
	default:
		xil_printf("Error: invalid pattern passed to DemoPrintTest");
	}
}

