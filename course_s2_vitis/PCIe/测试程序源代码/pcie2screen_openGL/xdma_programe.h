#ifndef XDMA_PROGRAME_H
#define XDMA_PROGRAME_H

#include <pthread.h>
#include <sys/time.h>
#include <QtWidgets>

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <strsafe.h>

#include <Windows.h>
#include <SetupAPI.h>
#include <INITGUID.H>
#include <WinIoCtl.h>

#include "xdma_public.h"

class xdma_programe
{
public:
    xdma_programe();
    ~xdma_programe();
    bool getDevice(void);
    int read_pack(char *pData, int len);

private:
    HANDLE dev_fd;
};

#endif // XDMA_PROGRAME_H
