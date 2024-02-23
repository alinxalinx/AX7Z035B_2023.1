#include "main_window.h"
#include "xdma_programe.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    setWindowTitle(tr("芯驿电子PCIE管理工具(V1.01)"));

    QWidget *pCentralWidget = new QWidget;
    setCentralWidget(pCentralWidget);

    pCentralWidget->setObjectName("centerwidget");
    pCentralWidget->setStyleSheet("#centerwidget{"
                                  "background:#888;border:1px solid #000;}");
    pUserUi = new user_ui;
    QHBoxLayout *setUserLayout = new QHBoxLayout(pCentralWidget);
    setUserLayout->setMargin(1);
    setUserLayout->setSpacing(0);
    setUserLayout->addWidget(pUserUi);

    QObject::connect(pUserUi->pButStart, SIGNAL(clicked(bool)), this, SLOT(app_error()));
    QObject::connect(pUserUi->pPcieManage->pButRead, SIGNAL(clicked(bool)), this, SLOT(pcie_opt()));
    QObject::connect(pUserUi->pPcieManage->pButWrite, SIGNAL(clicked(bool)), this, SLOT(pcie_opt()));
    resize(640, 400);

    pXdma = new xdma_programe;
    if(pXdma->getDevice())
    {
        pUserUi->pButStart->hide();
    }
    else
    {
        pUserUi->pButStart->setText(tr("设备未就绪"));
        pUserUi->pPcieManage->hide();
    }
    pUserUi->pPcieManage->pComboBox->setCurrentIndex(2);
    dataBuffLen = 1920*1080*3;

    SYSTEM_INFO sys_info;
    GetSystemInfo(&sys_info);
    pDataBuff = (char *)_aligned_malloc(dataBuffLen, sys_info.dwPageSize);
    pTimer = new QTimer;
    opt_mode = 0;
    QObject::connect(pXdma, SIGNAL(opt_end(int)), this, SLOT(opt_end(int)));
    QObject::connect(pTimer, SIGNAL(timeout()), this, SLOT(opt_timeout()));
    pXdma->start();
}

MainWindow::~MainWindow()
{
    _aligned_free(pDataBuff);
}

void MainWindow::app_error()
{
    //
}

void MainWindow::pcie_opt()
{
    unsigned int addr;
    int index = pUserUi->pPcieManage->pComboBox->currentIndex();
    QPushButton *but = qobject_cast<QPushButton *>(sender());


    if(pUserUi->pPcieManage->pLineEditAddr->text().length() == 0)
    {
        pUserUi->pPcieManage->pLineEditAddr->setText("0");
    }
    if(pUserUi->pPcieManage->pLineEditLength->text().length() == 0)
    {
        pUserUi->pPcieManage->pLineEditLength->setText("8");
    }
    if((pUserUi->pPcieManage->pLineEditAddr->text().length() > 3) &&
            (pUserUi->pPcieManage->pLineEditAddr->text().at(0) == '0')&&
            ((pUserUi->pPcieManage->pLineEditAddr->text().at(1) == 'x')||
             ((pUserUi->pPcieManage->pLineEditAddr->text().at(1) == 'X'))))
    {
        addr = pUserUi->pPcieManage->pLineEditAddr->text().mid(2).toUInt(NULL, 16);
    }
    else
    {
        addr = pUserUi->pPcieManage->pLineEditAddr->text().toUInt();
    }

    if(but == pUserUi->pPcieManage->pButRead)
    {
        if((pUserUi->pPcieManage->pLineEditLength->text().length() > 3) &&
                (pUserUi->pPcieManage->pLineEditLength->text().at(0) == '0')&&
                ((pUserUi->pPcieManage->pLineEditLength->text().at(1) == 'x')||
                 ((pUserUi->pPcieManage->pLineEditLength->text().at(1) == 'X'))))
        {
            opt_len = pUserUi->pPcieManage->pLineEditLength->text().mid(2).toInt(NULL, 16);
        }
        else
        {
            opt_len = pUserUi->pPcieManage->pLineEditLength->text().toInt();
        }

        if(opt_len > dataBuffLen)
        {
            opt_len = dataBuffLen;
        }
        if(opt_len <= 0)
        {
            return;
        }
        opt_mode = index;
        pXdma->opt_pack(opt_mode, pDataBuff, opt_len, addr);
    }
    else
    {
        QByteArray ba = pUserUi->pPcieManage->pTextEdit->toPlainText().toLocal8Bit();
        opt_len = getHexFromText(ba.data(), ba.length(), (unsigned char *)pDataBuff, dataBuffLen);
        if(opt_len <= 0)
        {
            return;
        }
        opt_mode = index+3;
        pXdma->opt_pack(opt_mode, pDataBuff, opt_len, addr);
    }
    pTimer->start(2000);
}

void MainWindow::opt_end(int rw)
{
    if(rw == 0)
    {
        getTextFromHex((unsigned char *)pDataBuff, opt_len, strBuff);
        pUserUi->pPcieManage->pTextEdit->setText(strBuff);
    }
    else
    {
    }
    pTimer->stop();
}

void MainWindow::opt_timeout()
{
    pUserUi->pButStart->setText(tr("驱动故障"));
    pUserUi->pButStart->show();
    pUserUi->pPcieManage->hide();
    pTimer->stop();
}

