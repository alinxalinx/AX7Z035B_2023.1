#ifndef XDMA_PROGRAME_H
#define XDMA_PROGRAME_H

#include <pthread.h>
#include <sys/time.h>
#include <QtWidgets>

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>


class xdma_programe
{
public:
    xdma_programe();
    ~xdma_programe();
    bool getDevice(void);
    int read_pack(char *pData, int len);

private:
    int dev_fd;
};

#endif // XDMA_PROGRAME_H
