#include "user_ui.h"

user_ui::user_ui(QWidget *parent)
    : QFrame(parent)
{
    setStyleSheet("user_ui{"
                  "background:#444;border:1px solid #777;}"
                  "#mainui{"
                  "border:1px solid #222;}"
                  "QLabel{color:white;font-size:12px;}");
    QVBoxLayout *pLayout = new QVBoxLayout(this);
    pLayout->setMargin(0);

    QFrame *pUI = new QFrame;
    pUI->setObjectName("mainui");
    pLayout->addWidget(pUI);

    QGridLayout *pUserLayout = new QGridLayout(pUI);

    pButStart = new QPushButton;
    pButStart->setStyleSheet("QPushButton{"
                             "background-color:rgba(0, 0, 0, 50);"
                             "border-style: outset;"
                             "border-width: 2px;"
                             "border-radius: 5px;"
                             "border-color: #8B7355;"
                             "font: bold 28px;"
                             "min-width:200px;max-width:200px;"
                             "min-height:40px;max-height:40px;"
                             "color:white;"
                             "font-family:华文新魏;"
                             "}"
                             "QPushButton:hover{"
                             "background-color:rgba(0, 0, 0, 100);"
                             "}"
                             "QPushButton:pressed{"
                             "background-color:rgba(0, 0, 0, 100);"
                             "border-style: inset;"
                             "padding-top:1px;padding-bottom:-1px;"
                             "padding-left:1px;padding-right:-1px;"
                             "}");
    pUserLayout->addWidget(pButStart);

    pPcieManage = new pcie_manage;
    pUserLayout->addWidget(pPcieManage);

}
