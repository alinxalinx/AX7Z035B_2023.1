#include <unistd.h>
#include "set_capture.h"

xdma_getImg::xdma_getImg(xdma_programe *pXdma, char *pRGB, pthread_mutex_t *pOptNotice)
{
    stateWorking = false;
    this->pRGB = pRGB;
    this->pXdma = pXdma;
    this->pOptNotice = pOptNotice;
    start();
}

void xdma_getImg::run()
{
    int i;

    while(1)
    {
        if(stateWorking)
        {
            pthread_mutex_lock(pOptNotice);
            i = pXdma->read_pack(pRGB, 1920*1080*3);
            if(i != 1920*1080*3)
            {
                qDebug("read one pack error %d", i);
            }
            emit flushImg();
        }
        else
        {
            usleep(100000);
        }

    }
}

void xdma_getImg::setstart(bool isRuning)
{
    stateWorking = isRuning;
}
