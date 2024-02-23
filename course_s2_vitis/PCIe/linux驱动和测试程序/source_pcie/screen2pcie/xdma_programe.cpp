#include <unistd.h>
#include "xdma_programe.h"
#include <assert.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

//#define DEVICE_NAME_DEFAULT "/dev/xdma/card0/h2c0"
#define DEVICE_NAME_DEFAULT "/dev/xdma0_h2c_0"
#define IMG_RAM_POS     (512*1024*1024)

xdma_programe::xdma_programe()
{
    fpga_fd = open(DEVICE_NAME_DEFAULT, O_RDWR | O_NONBLOCK);
}

xdma_programe::~xdma_programe()
{
    if(fpga_fd != -1)
    {
        close(fpga_fd);
    }
}

int xdma_programe::write_pack(char *pData, int len)
{
    char buff[1920*200*3];
    lseek(fpga_fd, IMG_RAM_POS, SEEK_SET);
    for(int i=0,b=0,n;i<len;i+=n)
    {
         n = ((len-i) > 1920*200) ? 1920*200 : len-i;
         for(int j=0,a=0;j<n;j++)
         {
             buff[a+0] = pData[b + 0];
             buff[a+1] = pData[b + 1];
             buff[a+2] = pData[b + 2];
             a += 3;
             b += 4;
         }
         write(fpga_fd, buff, n*3);
    }
    return len;
}

bool xdma_programe::getDevice()
{
    if(fpga_fd != -1)
    {
        return true;
    }
    else
    {
        return false;
    }
}


