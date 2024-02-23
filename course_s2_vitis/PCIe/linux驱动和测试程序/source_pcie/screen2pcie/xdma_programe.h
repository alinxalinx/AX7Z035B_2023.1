#ifndef XDMA_PROGRAME_H
#define XDMA_PROGRAME_H

#include <pthread.h>
#include <sys/time.h>
#include <QtWidgets>

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

class xdma_programe
{
public:
    xdma_programe();
    ~xdma_programe();
    bool getDevice(void);
    int write_pack(char *pData, int len);

private:
    int fpga_fd;
};

#endif // XDMA_PROGRAME_H
