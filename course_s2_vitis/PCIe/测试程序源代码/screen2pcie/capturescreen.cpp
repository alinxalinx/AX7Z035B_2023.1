#include "capturescreen.h"

captureScreen::captureScreen()
{
    HDC         m_hRootDC;
    HBITMAP     m_hBitmapMem;
    BITMAPINFO  m_bitmapInfo;
    int w, h;

    w = GetSystemMetrics(SM_CXSCREEN);
    h = GetSystemMetrics(SM_CYSCREEN);

    //InitBitmapInfo
    m_hRootDC = GetDC(NULL);
    if (!m_hRootDC)
    {
        isValid = false;
        return;
    }
    init_w = GetDeviceCaps(m_hRootDC, DESKTOPHORZRES);
    init_h = GetDeviceCaps(m_hRootDC, DESKTOPVERTRES);
    scale_w = init_w/w;
    scale_h = init_h/h;

    m_hMemDC = CreateCompatibleDC(m_hRootDC);
    if (!m_hMemDC)
    {
        isValid = false;
        return;
    }

    m_hBitmapMem = CreateDiscardableBitmap(m_hRootDC, init_w, init_h);
    if (!m_hBitmapMem)
    {
        isValid = false;
        return;
    }

    //CreateDIBBuffers
    m_bitmapInfo.bmiHeader.biSize     = sizeof(BITMAPINFOHEADER);
    m_bitmapInfo.bmiHeader.biBitCount = 0;
    if (GetDIBits(m_hMemDC, m_hBitmapMem, 0, 1, NULL, &m_bitmapInfo, DIB_RGB_COLORS) == 0)
    {
        isValid = false;
        return;
    }
    m_bitmapInfo.bmiHeader.biCompression = BI_RGB;
    //因为抓取的图片是上下颠倒的，所以这里需要将高度颠倒一下
    m_bitmapInfo.bmiHeader.biHeight = -abs(m_bitmapInfo.bmiHeader.biHeight);
    hBitmapTmp = CreateDIBSection(m_hRootDC, &m_bitmapInfo, DIB_RGB_COLORS, (void **)&pColorAry, NULL, 0);
    hdcTmp = NULL;
    SelectObject(m_hMemDC, hBitmapTmp);

    isValid = true;
}

void captureScreen::captureOnce()
{
    int x, y;

    if(hdcTmp)
    {
        ReleaseDC(NULL, hdcTmp);
    }
    hdcTmp = GetDC(NULL);
    BitBlt(m_hMemDC, 0, 0, init_w, init_h, hdcTmp, 0, 0, SRCCOPY|CAPTUREBLT);

    CURSORINFO CursorInfo;
    CursorInfo.cbSize = sizeof(CursorInfo);
    if(GetCursorInfo(&CursorInfo) == false)
    {
        return;
    }
    if(GetIconInfo(CursorInfo.hCursor, & IconInfo) == false)
    {
        return;
    }
    x = CursorInfo.ptScreenPos.x - IconInfo.xHotspot;
    y = CursorInfo.ptScreenPos.y - IconInfo.yHotspot;
    if(scale_w > 1)
    {
        x = x*scale_w;
    }
    if(scale_h > 1)
    {
        y = y*scale_h;
    }
    DrawIconEx(m_hMemDC, x, y, CursorInfo.hCursor, 0, 0, 0, NULL, DI_NORMAL | DI_COMPAT);
    if(IconInfo.hbmMask)
    {
        DeleteObject(IconInfo.hbmMask);
    }
    if(IconInfo.hbmColor)
    {
        DeleteObject(IconInfo.hbmColor);
    }
}


