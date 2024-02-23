#include "main_window.h"
#include "xdma_programe.h"

MainWindow::MainWindow(QWidget *parent)
    : QWidget(parent, Qt::FramelessWindowHint|Qt::WindowSystemMenuHint)
{

    setAttribute(Qt::WA_TranslucentBackground);
    QGraphicsDropShadowEffect *effect = new QGraphicsDropShadowEffect;
    effect->setBlurRadius(16);
    effect->setColor(Qt::black);
    effect->setOffset(0,0);

    QFrame *pFrameMenu = new QFrame;
    QVBoxLayout *pLayout = new QVBoxLayout(this);
    pFrameMenu->setGraphicsEffect(effect);
    pLayout->addWidget(pFrameMenu, 1);

    pFrameMenu->setObjectName("mainWidget");
    pFrameMenu->setStyleSheet("#mainWidget{"
                              "background:#ccc;"
                              "border-radius:5px;"
                              "border:1px solid #000;}");

    QVBoxLayout *pVBox = new QVBoxLayout(pFrameMenu);
    QWidget *head_tool = new QWidget;
    QWidget *user_ui = new QWidget;
    head_tool->setObjectName("head_tool");
    head_tool->setStyleSheet("#head_tool{"
                             "background:#888;"
                             "border-top-left-radius:5px;"
                             "border-top-right-radius:5px;"
                             "border:1px solid #aaa;"
                             "border-bottom:none;}");
    user_ui->setObjectName("user_ui");
    user_ui->setStyleSheet("#user_ui{"
                           "background:#888;"
                           "border-bottom-left-radius:5px;"
                           "border-bottom-right-radius:5px;"
                           "border:1px solid #aaa;"
                           "border-top:none;}");
    pVBox->addWidget(head_tool);
    pVBox->addWidget(user_ui, 1);
    pVBox->setMargin(0);
    pVBox->setSpacing(0);

    QLabel *pVersion = new QLabel;
    QPushButton *pButMin = new QPushButton;
    pButMin->setStyleSheet("QPushButton{"
                           "outline:none;"
                           "min-height: 23px;min-width: 23px;"
                           "max-height: 23px;max-width: 23px;"
                           "border-image: url(:/img/sys_min.png) 0 69 0 0;}"
                           "QPushButton:hover{border-image: url(:/img/sys_min.png) 0 46 0 23;}"
                           "QPushButton:pressed{border-image: url(:/img/sys_min.png) 0 23 0 46;}");
    QPushButton *pButClose = new QPushButton;
    pButClose->setStyleSheet("QPushButton{"
                             "outline:none;"
                             "min-height: 23px;min-width: 23px;"
                             "max-height: 23px;max-width: 23px;"
                             "border-image: url(:/img/sys_close.png) 0 69 0 0;}"
                             "QPushButton:hover{border-image: url(:/img/sys_close.png) 0 46 0 23;}"
                             "QPushButton:pressed{border-image: url(:/img/sys_close.png) 0 23 0 46;}");
    QHBoxLayout *pHeaderToolLayout = new QHBoxLayout(head_tool);
    QHBoxLayout *setCaptureLayout = new QHBoxLayout(user_ui);

    pVersion->setStyleSheet("color:#333;font:bold 14px;");
    pVersion->setText(tr("芯驿电子(ALINX) PCIE图像传输(V1.01)"));

    pHeaderToolLayout->insertWidget(0, pButClose);
    pHeaderToolLayout->insertWidget(0, pButMin);
    pHeaderToolLayout->insertStretch(0, 1);
    pHeaderToolLayout->insertWidget(0, pVersion);
    pHeaderToolLayout->setMargin(4);

    pSetCapture = new set_capture;
    setCaptureLayout->setContentsMargins(4, 0, 4, 4);
    setCaptureLayout->addWidget(pSetCapture);

    QObject::connect(pButMin, SIGNAL(clicked(bool)), this, SLOT(showMinimized()));
    QObject::connect(pButClose, SIGNAL(clicked(bool)), this, SLOT(readyExit()));
    QObject::connect(pSetCapture->pButStart, SIGNAL(clicked(bool)), this, SLOT(startCapture()));
    resize(640, 400);

    pthread_t pid;
    task_ready();

    xdma_programe *pXdma = new xdma_programe;
    if(pXdma->getDevice())
    {
        pthread_create(&pid, NULL, task_xdma, pXdma);
        pthread_create(&pid, NULL, task_capture, NULL);
        pSetCapture->pButStart->setText(tr("开始屏幕映射"));
    }
    else
    {
        pSetCapture->pButStart->setText(tr("设备未就绪"));
    }
    exitFlag = 0;
}

MainWindow::~MainWindow()
{
}

void MainWindow::startCapture()
{
    if(pSetCapture->pButStart->text() == tr("设备未就绪"))
    {
        return;
    }
    if(pSetCapture->pButStart->text() == tr("开始屏幕映射"))
    {
        pSetCapture->pButStart->setText(tr("停止屏幕映射"));
        task_setWork(true);
    }
    else
    {
        pSetCapture->pButStart->setText(tr("开始屏幕映射"));
        task_setWork(false);
    }
}

void MainWindow::readyExit()
{
    QTimer *pTimer;

    if(exitFlag == 0)
    {
        pSetCapture->pButStart->setText(tr("退出屏幕映射"));
        pTimer= new QTimer;
        QObject::connect(pTimer, SIGNAL(timeout()), this, SLOT(readyExit()));
        pTimer->start(1000);
    }
    else
    {
        close();
    }
    exitFlag++;
}

void MainWindow::mousePressEvent(QMouseEvent *event)
{
    isPress = true;
    postion = event->globalPos()-pos();
}

void MainWindow::mouseReleaseEvent(QMouseEvent *)
{
    int x, y, c=0;
    int hold = 60;

    isPress = false;
    x = pos().x();
    y = pos().y();
    if((x+width()) < hold)
    {
        x = hold-width();
        c = 1;
    }
    else if((x+hold) > QApplication::desktop()->geometry().width())
    {
        x = QApplication::desktop()->geometry().width() - hold;
        c = 1;
    }
    if((y+height()) < hold)
    {
        y = hold-height();
        c = 1;
    }
    else if((y+hold) > QApplication::desktop()->geometry().height())
    {
        y = QApplication::desktop()->geometry().height() - hold;
        c = 1;
    }
    if(c)
    {
        move(x, y);
    }
}

void MainWindow::mouseMoveEvent(QMouseEvent *event)
{
    if(isPress && (event->buttons()&Qt::LeftButton))
    {
        move(event->globalPos()-postion);
    }
}

void MainWindow::closeEvent(QCloseEvent *ev)
{
    if(exitFlag == 0)
    {
        ev->ignore();
        readyExit();
    }
    else
    {
        ev->accept();
    }
}
