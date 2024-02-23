#ifndef PCIE_MANAGE_H
#define PCIE_MANAGE_H

#include <QtWidgets>

class pcie_manage : public QFrame
{
    Q_OBJECT
public:
    explicit pcie_manage(QWidget *parent = 0);


    void reciveData(unsigned char *pData, int *len);

signals:

public slots:

public:
    QLabel *pLabOpt;
    QLabel *pLabAddr;
    QLabel *pLabLength;
    QComboBox *pComboBox;
    QLineEdit *pLineEditAddr;
    QLineEdit *pLineEditLength;
    QPushButton *pButRead;
    QPushButton *pButWrite;
    QTextEdit *pTextEdit;
};

int getHexFromText(char *pParseData, int parseLen, unsigned char *pBackData, int maxlen);
void getTextFromHex(unsigned char *pData, int len, QString &str);

#endif // PCIE_MANAGE_H
