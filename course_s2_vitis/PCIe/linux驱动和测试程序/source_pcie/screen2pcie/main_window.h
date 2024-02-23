#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#include <QtWidgets>
#include "set_capture.h"

class MainWindow : public QWidget
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

public Q_SLOTS:
    void startCapture(void);
    void readyExit(void);

private:
    set_capture *pSetCapture;

    void mousePressEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    bool isPress;
    QPoint postion;
    int exitFlag;

protected:
    void closeEvent(QCloseEvent *);


};

#endif // MAIN_WINDOW_H
