#include <unistd.h>
#include "set_capture.h"
#include "xdma_programe.h"
#include "capturescreen.h"

set_capture::set_capture(QWidget *parent)
    : QFrame(parent)
{
    setStyleSheet("set_capture{"
                  "background:#444;border:1px solid #777;"
                  "border-bottom-left-radius:3px;"
                  "border-bottom-right-radius:3px;}"
                  "#mainui{"
                  "border:1px solid #222;"
                  "border-bottom-left-radius:3px;"
                  "border-bottom-right-radius:3px;}"
                  "QLabel{color:white;font-size:12px;}");
    QVBoxLayout *pLayout = new QVBoxLayout(this);
    pLayout->setMargin(0);

    QFrame *pUI = new QFrame;
    pUI->setObjectName("mainui");
    pLayout->addWidget(pUI);

    QGridLayout *pUserLayout = new QGridLayout(pUI);

    pButStart = new QPushButton;
    pButStart->setStyleSheet("QPushButton{"
                             "background-color:rgba(0, 0, 0, 50);"
                             "border-style: outset;"
                             "border-width: 2px;"
                             "border-radius: 5px;"
                             "border-color: #8B7355;"
                             "font: bold 28px;"
                             "min-width:200px;max-width:200px;"
                             "min-height:40px;max-height:40px;"
                             "color:white;"
                             "font-family:华文新魏;"
                             "}"
                             "QPushButton:hover{"
                             "background-color:rgba(0, 0, 0, 100);"
                             "}"
                             "QPushButton:pressed{"
                             "background-color:rgba(0, 0, 0, 100);"
                             "border-style: inset;"
                             "padding-top:1px;padding-bottom:-1px;"
                             "padding-left:1px;padding-right:-1px;"
                             "}");
    pUserLayout->addWidget(pButStart);
}

static char *ppDualRam[2];
static bool stateWorking;
static int indexDualRam;
static pthread_mutex_t task_notice;

void task_ready(void)
{
    int i;

    for(i=0;i<2;i++)
    {
        ppDualRam[i] = (char *)malloc(1920*1080*3);
    }
    indexDualRam = 0;
    stateWorking = false;
    pthread_mutex_init(&task_notice, NULL);
    pthread_mutex_lock(&task_notice);
}

void task_setWork(bool isRuning)
{
    stateWorking = isRuning;
}

void *task_capture(void *)
{
    int w, h, x, y, n, m;
    unsigned int *pColorAry;
    char *pData;
    captureScreen *pCaptureScreen = new captureScreen;

    while(1)
    {
        if(stateWorking)
        {
            pCaptureScreen->captureOnce();
            pColorAry = pCaptureScreen->pColorAry;
            w = pCaptureScreen->init_w;
            h = pCaptureScreen->init_h;
            n = 0;
            m = 0;
            pData = ppDualRam[indexDualRam];
            for (y = 0; y < h; y++)
            {
                for (x = 0; x < w; x++)
                {
                    pData[n++] = GetRValue(pColorAry[m]);
                    pData[n++] = GetGValue(pColorAry[m]);
                    pData[n++] = GetBValue(pColorAry[m]);
                    m++;
                }
            }
            indexDualRam = indexDualRam?0:1;
            pthread_mutex_unlock(&task_notice);
        }
        else
        {
            usleep(100000);
        }
    }
    return NULL;
}

void *task_xdma(void *pArg)
{
    char *pData;
    xdma_programe *pXdma = (xdma_programe *)pArg;

    if(pXdma->getDevice() == false)
    {
        return NULL;
    }
    while(1)
    {
        pthread_mutex_lock(&task_notice);
        pData = indexDualRam?ppDualRam[0]:ppDualRam[1];
        pXdma->write_pack(pData, 1920*1080*3);
    }
    return NULL;
}
