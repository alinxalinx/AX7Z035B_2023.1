#include <stdio.h>
#include <unistd.h>
#include "xil_types.h"
#include "i2c/PS_i2c.h"

u8 sil9011_init_data[][2] =
{
		{0x05, 0x10},
		{0x08, 0x05},
		{0x09, 0x01},
		{0x05, 0x04},
		{0xb5, 0x04},
		{0xff, 0xff}
};


void sil9011_init(unsigned int DeviceId)
{
	XIicPs IicInstance;

	if (i2c_init(&IicInstance, DeviceId, 100000) != XST_SUCCESS)
	{
		printf("XIicPs_Initialize failed!\n");
		return;
	}
	usleep(50000);
	for(int i=0;;i++)
	{
		if((sil9011_init_data[i][0] == 0xff) && (sil9011_init_data[i][1] == 0xff))
		{
			break;
		}
		i2c_reg8_write(&IicInstance, 0x60>>1, (unsigned char)sil9011_init_data[i][0], (unsigned char)sil9011_init_data[i][1]);
	}
}
