#ifndef CAPTURESCREEN_H
#define CAPTURESCREEN_H

#include <windows.h>
#include <gdiplus.h>

class captureScreen
{
public:
    captureScreen();
    void captureOnce();
    int init_w;
    int init_h;
    int scale_w;
    int scale_h;

    HDC     m_hMemDC;
    HBITMAP hBitmapTmp;
    unsigned int *pColorAry;
    ICONINFO IconInfo;

    HDC hdcTmp;

    bool isValid;
};

#endif // CAPTURESCREEN_H
