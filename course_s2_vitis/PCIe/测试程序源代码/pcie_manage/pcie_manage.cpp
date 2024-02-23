#include "pcie_manage.h"

pcie_manage::pcie_manage(QWidget *parent)
    : QFrame(parent)
{
    setStyleSheet(""
                  "*{font-size:16px;color:#fff;font-family:华文新魏;}"
                  "QComboBox{"
                  "padding:6px;"
                  "padding-top:2px;"
                  "padding-bottom:2px;"
                  "border:1px solid #000;"
                  "background-color:#555;"
                  "color:#fff;}"
                  "QComboBox QAbstractItemView"
                  "{"
                  "border:1px solid black;"
                  "background-color:#555;"
                  "selection-color:#fff;"
                  "selection-background-color:#777;"
                  "outline:0px;"
                  "}"
                  "QComboBox QAbstractItemView::item"
                  "{"
                  "min-height: 20px;"
                  "}"
                  "QLineEdit"
                  "{"
                  "border:1px solid #000;"
                  "padding:2px;"
                  "background-color:#555;"
                  "max-width:100px;min-width:100px;"
                  "}"
                  "QPushButton{"
                  "background-color:rgba(0, 0, 0, 50);"
                  "border-style: outset;"
                  "border-width: 2px;"
                  "border-color: #8B7355;"
                  "min-width:80px;"
                  "padding-top:2px;padding-bottom:2px;"
                  "}"
                  "QPushButton:hover{"
                  "background-color:rgba(0, 0, 0, 100);"
                  "}"
                  "QPushButton:pressed{"
                  "background-color:rgba(0, 0, 0, 100);"
                  "border-style: inset;"
                  "padding-top:1px;padding-bottom:-1px;"
                  "padding-left:1px;padding-right:-1px;"
                  "}"
                  "QTextEdit"
                  "{"
                  "background-color:#555;"
                  "border:1px solid #000;"
                  "}"
                  "");
    QGridLayout *pLayout = new QGridLayout(this);

    pLabOpt = new QLabel;
    pLabAddr = new QLabel;
    pLabLength = new QLabel;
    pComboBox = new QComboBox;
    pLineEditAddr = new QLineEdit;
    pLineEditLength = new QLineEdit;
    pButRead = new QPushButton;
    pButWrite = new QPushButton;
    pTextEdit = new QTextEdit;

    pLabOpt->setText(tr("操作模式"));
    pLabAddr->setText(tr("操作地址"));
    pLabLength->setText(tr("读取长度"));
    pComboBox->setItemDelegate(new QStyledItemDelegate());
    pComboBox->addItem(tr("控制模式"));
    pComboBox->addItem(tr("用户模式"));
    pComboBox->addItem(tr("内存模式"));
    pButRead->setText(tr("读"));
    pButWrite->setText(tr("写"));

    QLabel *pLabWarning = new QLabel;
    pLabWarning->setStyleSheet("QLabel{"
                               "color:#AB9375;"
                               "background-image:url(:/img/warning.png);"
                               "background-repeat:no-repeat;"
                               "background-position:left center;"
                               "padding-left:60px;"
                               "padding-top:-8px;"
                               "padding-bottom:-8px;"
                               "border:1px solid #AB9375;"
                               "max-width:150px;}");
    pLabWarning->setText(tr("错误的地址或数<br>据可能造成设备<br>异常或系统崩溃"));
    pLayout->setColumnStretch(1, 1);
    pLayout->addWidget(pLabWarning,     0, 0, 3, 1);
    pLayout->addWidget(pLabOpt,         0, 2);
    pLayout->addWidget(pComboBox,       0, 3);
    pLayout->addWidget(pLabAddr,        1, 2);
    pLayout->addWidget(pLineEditAddr,   1, 3);
    pLayout->addWidget(pButWrite,       1, 4);
    pLayout->addWidget(pLabLength,      2, 2);
    pLayout->addWidget(pLineEditLength, 2, 3);
    pLayout->addWidget(pButRead,        2, 4);
    pLayout->addWidget(pTextEdit,       3, 0, 1, 5);
}

int getHexFromText(char *pParseData, int parseLen, unsigned char *pBackData, int maxlen)
{
    int i;
    int cot=0;
    int sub=0;
    unsigned char d0;
    unsigned char d1;

    for(i=0;i<parseLen;i++)
    {
        if(pParseData[i] == ' ')
        {
            sub=0;
        }
        else
        {
            d1 = pParseData[i];
            if( (d1>='0') && (d1<='9') )
            {
                d1 -= '0';
            }
            else if( (d1>='a') && (d1<='f') )
            {
                d1 = d1-'a'+10;
            }
            else if( (d1>='A') && (d1<='F') )
            {
                d1 = d1-'A'+10;
            }
            else
            {
                continue;
            }
            if(sub)
            {
                d0 |= d1;
                pBackData[cot++] = d0;
                if(cot >= maxlen)
                {
                    break;
                }
                sub = 0;
            }
            else
            {
                sub = 1;
                d0 = d1<<4;
            }
        }
    }
    return cot;
}

void getTextFromHex(unsigned char *pData, int len, QString &str)
{
    char buff[10];

    str.resize(len*3);
    str = "";
    for(int i=0;i<len;i++)
    {
        sprintf(buff, "%02X", pData[i]);
        if(i)
        {
            str += " ";
        }
        str += buff;
    }
}
