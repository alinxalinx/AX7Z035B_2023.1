#include "main_window.h"

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
    QPushButton *pButClose = new QPushButton;
    pButClose->setStyleSheet("QPushButton{"
                             "outline:none;"
                             "min-height: 23px;min-width: 23px;"
                             "max-height: 23px;max-width: 23px;"
                             "border-image: url(:/img/close_b.png) 0 69 0 0;}"
                             "QPushButton:hover{border-image: url(:/img/close_b.png) 0 46 0 23;}"
                             "QPushButton:pressed{border-image: url(:/img/close_b.png) 0 23 0 46;}");
    QHBoxLayout *pHeaderToolLayout = new QHBoxLayout(head_tool);
    QHBoxLayout *pCheckSpeedLayout = new QHBoxLayout(user_ui);

    pVersion->setStyleSheet("color:#333;font:bold 14px;");
    pVersion->setText(tr("芯驿电子(ALINX) PCIE测速软件(V1.02)"));


    pHeaderToolLayout->insertWidget(0, pButClose);
    pHeaderToolLayout->insertStretch(0, 1);
    pHeaderToolLayout->insertWidget(0, pVersion);
    pHeaderToolLayout->setMargin(4);

    pCheckSpeed = new check_speed;
    pCheckSpeedLayout->setContentsMargins(4, 0, 4, 4);
    pCheckSpeedLayout->addWidget(pCheckSpeed);

    pXdmaR = new xdma_programe(false);
    pXdmaW = new xdma_programe(true);

    QObject::connect(pButClose, SIGNAL(clicked(bool)), this, SLOT(close()));
    QObject::connect(pCheckSpeed->pButStart, SIGNAL(clicked(bool)), this, SLOT(startSpeed(bool)));
    QObject::connect(pXdmaR, SIGNAL(reportSpeed(int,int)), this, SLOT(flushSpeed(int,int)));
    QObject::connect(pXdmaW, SIGNAL(reportSpeed(int,int)), this, SLOT(flushSpeed(int,int)));

    resize(640, 400);

    QString str;
    str = pXdmaR->getDevice();
    str = pXdmaW->getDevice();
    if(str.length() > 0)
    {
        pCheckSpeed->pDeviceList->addItem(tr("读写速度测试"));
        pCheckSpeed->pDeviceList->addItem(tr("只读速度测试"));
        pCheckSpeed->pDeviceList->addItem(tr("只写速度测试"));
    }
    else
    {
        pCheckSpeed->pDeviceList->addItem(tr("未检测到设备"));
    }
    pXdmaR->start();
    pXdmaW->start();
}

MainWindow::~MainWindow()
{
}

void MainWindow::startSpeed(bool)
{
    int index;

    if(pCheckSpeed->pButStart->text() == tr("开始测试"))
    {
        index = pCheckSpeed->pDeviceList->currentIndex();
        if(pCheckSpeed->pDeviceList->count() <= 1)
        {
            return;
        }
        if(index != 2)
        {
            pXdmaR->intoCheckSpeedMode(true);
        }
        else
        {
            pXdmaR->intoCheckSpeedMode(false);
        }
        if(index != 1)
        {
            pXdmaW->intoCheckSpeedMode(true);
        }
        else
        {
            pXdmaW->intoCheckSpeedMode(false);
        }
        pCheckSpeed->pButStart->setText(tr("停止测试"));
        pCheckSpeed->pDeviceList->setDisabled(true);
    }
    else
    {
        pCheckSpeed->pButStart->setText(tr("开始测试"));
        pXdmaR->intoCheckSpeedMode(false);
        pXdmaW->intoCheckSpeedMode(false);
        pCheckSpeed->pDeviceList->setDisabled(false);
    }
}

void MainWindow::flushSpeed(int speed0, int ch)
{
    pCheckSpeed->setSpeedValue(speed0, ch);
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
