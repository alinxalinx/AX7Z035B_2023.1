#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#include <QtWidgets>
#include "user_ui.h"

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();

public Q_SLOTS:
    void app_error(void);
    void pcie_opt(void);
    void opt_end(int rw);
    void opt_timeout(void);


private:
    user_ui *pUserUi;
    xdma_programe *pXdma;
    char *pDataBuff;
    int dataBuffLen;
    QString strBuff;
    QTimer *pTimer;
    int opt_mode;
    int opt_len;
};

#endif // MAIN_WINDOW_H
