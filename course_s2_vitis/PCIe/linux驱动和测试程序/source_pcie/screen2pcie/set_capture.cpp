#include <unistd.h>
#include "set_capture.h"
#include "xdma_programe.h"
#include <dirent.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <netdb.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <linux/fb.h>

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

bool working = false;
void *task_xdma(void *pArg)
{
    int fb;
    struct fb_var_screeninfo screeninfo_var;
    struct fb_fix_screeninfo screeninfo_fix;
    char *pData;
    xdma_programe *pXdma = (xdma_programe *)pArg;

    if(pXdma->getDevice() == false)
    {
        return NULL;
    }
    fb = open ("/dev/fb0", O_RDWR);
    if(fb < 0)
    {
        printf("open DEV_LCD fail:%d\n",fb);
        return NULL;
    }
    if(ioctl(fb, FBIOGET_VSCREENINFO, &screeninfo_var))
    {
        printf("get screen var info fail\n");
        return NULL;
    }
    if(ioctl(fb, FBIOGET_FSCREENINFO, &screeninfo_fix))
    {
        printf("get screen fix info fail\n");
        return NULL;
    }
    printf("width=%d\n", screeninfo_var.width);
    printf("width=%d\n", screeninfo_fix.smem_len);
    pData = (char *)mmap(0, 1920*1080*4, PROT_READ | PROT_WRITE, MAP_SHARED,fb, 0);
    if (pData == NULL)
    {
        printf("Error: failed to map framebuffer device to memory.\n");
        return NULL;
    }
    while(1)
    {
        if(working)
        {
            pXdma->write_pack(pData, 1920*1080);
        }
        else
        {
            usleep(100000);
        }
    }
    return NULL;
}
