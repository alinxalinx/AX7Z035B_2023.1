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

class xdma_programe : public QThread
{
    Q_OBJECT

public:
    xdma_programe();
    ~xdma_programe();
    bool getDevice(void);
    int read_pack(HANDLE hand, char *pData, int len, unsigned int offset);
    int write_pack(HANDLE hand, char *pData, int len, unsigned int offset);
    void run(void);
    void opt_pack(int mode, char *pData, int len, unsigned int offset);

Q_SIGNALS:
    void opt_end(int mode);

private:
    HANDLE devReadHandle[3];
    HANDLE devWriteHandle[3];
    char *pReadyData;
    int pReadyLen;
    unsigned int pReadyOffset;
    int mode;
};

#endif // XDMA_PROGRAME_H
