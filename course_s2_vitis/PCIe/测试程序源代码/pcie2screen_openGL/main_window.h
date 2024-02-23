#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#include <QtWidgets>
#include "set_capture.h"
#include "opengl_yuv.h"
#include "ulabel.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

public Q_SLOTS:
    void startCapture(void);
    void changeWindows(int);
    void timeDelay();
    void flushFps(int speed);

private:
    uOpenglYuv *pOpenGLFrame;
    xdma_getImg *pXdmaGetImg;
    QLabel *pPlayState;
    QTimer *pTimer;
    bool isPressed;
    bool isRelease;
    QString titleName;
};

#endif // MAIN_WINDOW_H
