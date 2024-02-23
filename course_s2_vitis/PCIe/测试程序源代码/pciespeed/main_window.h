#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#include <QtWidgets>
#include "check_speed.h"
#include "xdma_programe.h"

class MainWindow : public QWidget
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

public Q_SLOTS:
    void startSpeed(bool);
    void flushSpeed(int speed0, int ch);

private:
    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);

    bool isPress;
    QPoint postion;
    check_speed *pCheckSpeed;
    xdma_programe *pXdmaR;
    xdma_programe *pXdmaW;


};

#endif // MAIN_WINDOW_H
