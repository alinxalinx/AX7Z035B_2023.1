#ifndef SET_CAPTURE_H
#define SET_CAPTURE_H

#include <QtWidgets>
#include "xdma_programe.h"

class xdma_getImg : public QThread
{
    Q_OBJECT
public:
    xdma_getImg(xdma_programe *pXdma, char *pRGB, pthread_mutex_t *pOptNotice);
    void run(void);
    void setstart(bool isRuning);

Q_SIGNALS:
    void flushImg();

private:
    xdma_programe *pXdma;
    bool stateWorking;
    char *pRGB;
    pthread_mutex_t *pOptNotice;
};


#endif // SET_CAPTURE_H
