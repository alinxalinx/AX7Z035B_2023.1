#include <stdio.h>
#include <unistd.h>
#include "xil_types.h"
#include "i2c/PS_i2c.h"

u8 adv7511_init_data[][2] =
{
		{0x41, 0x00},
		{0x98, 0x03},
		{0x9a, 0xe0},
		{0x9c, 0x30},
		{0x9d, 0x61},
		{0xa2, 0xa4},
		{0xa3, 0xa4},
		{0xe0, 0xd0},
		{0x55, 0x12},
		{0xf9, 0x00},
		{0x15, 0x00},
		{0xd0, 0x3c},
		{0xaf, 0x04},
		{0x4c, 0x04},
		{0x40, 0x00},
		{0xd6, 0xc0},
		{0xff, 0xff}
};


void adv7511_init(void)
{
	XIicPs IicInstance;

	if (i2c_init(&IicInstance, XPAR_PS7_I2C_0_DEVICE_ID, 100000) != XST_SUCCESS)
	{
		printf("XIicPs_Initialize failed!\n");
		return;
	}
	usleep(50000);
	for(int i=0;;i++)
	{
		if((adv7511_init_data[i][0] == 0xff) && (adv7511_init_data[i][1] == 0xff))
		{
			break;
		}
		i2c_reg8_write(&IicInstance, 0x72>>1, (unsigned char)adv7511_init_data[i][0], (unsigned char)adv7511_init_data[i][1]);
	}
}
