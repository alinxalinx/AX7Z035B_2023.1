#include "PS_i2c.h"
#include "xparameters.h"
XIicPs IicInstance;

int i2c_init(XIicPs *IicInstance, u16 DeviceId, u32 FsclHz)
{
	int Status;
	XIicPs_Config *ConfigPtr;	/* Pointer to configuration data */
	/*
	 * Initialize the IIC driver so that it is ready to use.
	 */
	ConfigPtr = XIicPs_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		return XST_FAILURE;
	}

	Status = XIicPs_CfgInitialize(IicInstance, ConfigPtr,
					ConfigPtr->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	/*
	 * Set the IIC serial clock rate.
	 */
	XIicPs_SetSClk(IicInstance, FsclHz);
	return XST_SUCCESS;
}

int i2c_wrtie_bytes(XIicPs *IicInstance,u8 i2c_slave_addr,void *buf,int byte_num)
{
	int Status;

	/*
	 * Send the Data.
	 */
	Status = XIicPs_MasterSendPolled(IicInstance, buf,
			byte_num, i2c_slave_addr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait until bus is idle to start another transfer.
	 */
	while (XIicPs_BusIsBusy(IicInstance));

	/*
	 * Wait for a bit of time to allow the programming to complete
	 */
	usleep(2500);

	return XST_SUCCESS;
}

int i2c_read_bytes(XIicPs *IicInstance,u8 i2c_slave_addr,void *buf,int byte_num)
{
	int Status;

	Status = XIicPs_MasterRecvPolled(IicInstance, buf,
			byte_num, i2c_slave_addr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Wait until bus is idle to start another transfer.
	 */
	while (XIicPs_BusIsBusy(IicInstance));

	return XST_SUCCESS;
}

u8 i2c_reg8_read(XIicPs *IicInstance,u8 i2c_slave_addr,u8 reg_addr)
{

	u8 buf[1];
	u8 read_buf[1];
	buf[0] = reg_addr;
	if(i2c_wrtie_bytes(IicInstance,i2c_slave_addr,buf,1) != XST_SUCCESS)
		return 0xff;
	if(i2c_read_bytes(IicInstance,i2c_slave_addr,read_buf,1) != XST_SUCCESS)
		return 0xff;
	return read_buf[0];
}

int i2c_reg8_write(XIicPs *IicInstance,u8 i2c_slave_addr,u8 reg_addr,u8 data)
{

	u8 buf[2];
	buf[0] = reg_addr;
	buf[1] = data;
	if(i2c_wrtie_bytes(IicInstance,i2c_slave_addr,buf,2) != XST_SUCCESS)
		return XST_FAILURE;
	return XST_SUCCESS;
}

