#include "check_speed.h"

check_speed::check_speed(QWidget *parent)
    : QFrame(parent)
{
    setStyleSheet("check_speed{"
                  "background:#444;border:1px solid #777;"
                  "border-bottom-left-radius:3px;"
                  "border-bottom-right-radius:3px;}");
    QVBoxLayout *pLayout = new QVBoxLayout(this);
    pLayout->setMargin(0);

    QFrame *pUI = new QFrame;
    pUI->setObjectName("mainui");
    pUI->setStyleSheet("#mainui{border:1px solid #222;border-bottom-left-radius:3px;border-bottom-right-radius:3px;}"
                       "QLabel{color:white;font-size:12px;}");
    pLayout->addWidget(pUI);

    QGridLayout *pUserLayout = new QGridLayout(pUI);
    pDeviceList = new QComboBox(pUI);
    QStyledItemDelegate* itemDelegate = new QStyledItemDelegate();
    pDeviceList->move(8,8);
    pDeviceList->setItemDelegate(itemDelegate);
    pDeviceList->setStyleSheet("*{font-size:16px;}"
                               "QComboBox{"
                               "min-width:260px;"
                               "padding-left:6px;"
                               "padding-top:2px;"
                               "padding-bottom:2px;"
                               "border:1px solid #333;"
                               "border-top-right-radius: 3px;"
                               "border-top-left-radius: 3px;"
                               "background-color:#555;"
                               "color:#fff;}"
                               "QComboBox QAbstractItemView{"
                               "border:1px solid black;"
                               "background-color:#555;"
                               "selection-color:#fff;"
                               "selection-background-color:#777;"
                               "outline:0px;"
                               "}"
                               "QComboBox QAbstractItemView::item{"
                               "min-height: 20px;"
                               "}");
    pUserLayout->setContentsMargins(20, 60, 20, 20);

    QLabel *pLabel;
    for(int i=0;i<2;i++)
    {
        ppMeter[i] = new uMeter;
        pUserLayout->addWidget(ppMeter[i], 0, i);

        ppLCD[i] = new QLCDNumber(pUI);
        ppLCD[i]->setDigitCount(7);
        ppLCD[i]->setMode(QLCDNumber::Dec);
        ppLCD[i]->setSegmentStyle(QLCDNumber::Flat);
        ppLCD[i]->setStyleSheet("border:1px solid #111;color:yellow;background:#333;");
        ppLCD[i]->display("0000.00");
        ppLCD[i]->move(110+(286*i), 230);

        pLabel = new QLabel(pUI);
        i?pLabel->setText("写"):pLabel->setText("读");
        pLabel->move(156+(286*i), 266);
    }

    QString qss0 = "QPushButton {\
    background-color: rgba(0, 0, 0, 0);\
    border-style: outset;\
    border-width: 2px;\
    border-radius: 5px;\
    border-color: #8B7355;\
    font: bold 14px;\
    min-width:2em;\
    color:white;\
    font-family:华文新魏;\
    }\
    QPushButton:hover{\
    background-color: rgba(0, 0, 0, 50);\
    }\
    QPushButton:pressed {\
    background-color: rgba(30, 0, 30, 100);\
    border-style: inset;\
    padding-top:1px;padding-bottom:-1px;\
    padding-left:1px;padding-right:-1px;\
    }";

    pButStart = new QPushButton(pUI);
    pButStart->setText("开始测试");
    pButStart->setStyleSheet(qss0);
    pButStart->move(280, 8);
}

void check_speed::setSpeedValue(int speed, int ch)
{
    char buff[20];
    int a;

    sprintf(buff, "%04d.%02d", speed/100, speed%100);
    ppLCD[ch]->display(tr(buff));

    if((speed/100) > (ppMeter[ch]->m_maxValue))
    {
        ppMeter[ch]->m_maxValue = (speed/100/1000+1)*1000;
    }
    a = (speed*240/1000/100)/(ppMeter[ch]->m_maxValue/1000);
    ppMeter[ch]->m_Angle = -210+a;
    ppMeter[ch]->update();
}

