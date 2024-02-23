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
    xdma_programe(bool isWrite=TRUE);
    QString getDevice(void);
    bool intoCheckSpeedMode(bool start);


protected:
    void run(void);

private:
    bool speedWrite;
    bool speedRuning;
    HANDLE dev_fd;
    struct timeval last_time;
    struct timeval curr_time;
    unsigned long long dataCot;
    bool runChange;

Q_SIGNALS:
    void reportSpeed(int speed0, int speed1);
};

#endif // XDMA_PROGRAME_H
