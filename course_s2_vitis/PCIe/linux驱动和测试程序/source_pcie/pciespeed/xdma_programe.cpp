#include "xdma_programe.h"
#include <unistd.h>
#include <assert.h>
#include <fcntl.h>
#include <getopt.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>


xdma_programe::xdma_programe(bool isWrite)
    :QThread()
{
    speedWrite = isWrite;
    runChange = false;
    speedRuning = false;
    dev_fd = -1;
}

//#define DEVICE_NAME_READ "/dev/xdma/card0/c2h0"
#define DEVICE_NAME_READ "/dev/xdma0_c2h_0"
//#define DEVICE_NAME_WRITE "/dev/xdma/card0/h2c0"
#define DEVICE_NAME_WRITE "/dev/xdma0_h2c_0"
#define TEST_BUFF_LEN       (8*1024*1024)
#define TEST_OFFSET_RAM     (1024*1024*1024-TEST_BUFF_LEN)

void xdma_programe::run()
{
    char *pTestData;
    unsigned long long a;

    pTestData = (char *)((long long *)malloc(TEST_BUFF_LEN+7));

    while(1)
    {
        if(speedRuning != runChange)
        {
            if(dev_fd != -1)
            {
                speedRuning = runChange;
            }
            emit reportSpeed(0, (int)speedWrite);
            dataCot = 0;
            gettimeofday(&last_time, NULL);
        }

        if(speedRuning)
        {
            lseek(dev_fd, TEST_OFFSET_RAM, SEEK_SET);
            if(speedWrite)
            {
                write(dev_fd, pTestData, TEST_BUFF_LEN);
            }
            else
            {
                read(dev_fd, pTestData, TEST_BUFF_LEN);
            }
            dataCot += TEST_BUFF_LEN;
        }
        gettimeofday(&curr_time, NULL);
        a = curr_time.tv_sec*1000000+curr_time.tv_usec;
        a -= last_time.tv_sec*1000000;
        a -= last_time.tv_usec;
        if(a >= 500000)
        {
            dataCot = (dataCot/1024/1024)*(100000000)/a;
            emit reportSpeed(dataCot, (int)speedWrite);
            last_time.tv_sec = curr_time.tv_sec;
            last_time.tv_usec = curr_time.tv_usec;
            dataCot = 0;
        }
    }
}

QString xdma_programe::getDevice()
{
    QString str;

    if(dev_fd == -1)
    {
        if(speedWrite)
        {
            dev_fd = open(DEVICE_NAME_WRITE, O_RDWR | O_NONBLOCK);
        }
        else
        {
            dev_fd = open(DEVICE_NAME_READ, O_RDWR | O_NONBLOCK);
        }
    }

    if(dev_fd != -1)
    {
        str = "xdma_1";
    }
    return str;
}

bool xdma_programe::intoCheckSpeedMode(bool start)
{
    runChange = start;
    return true;
}

