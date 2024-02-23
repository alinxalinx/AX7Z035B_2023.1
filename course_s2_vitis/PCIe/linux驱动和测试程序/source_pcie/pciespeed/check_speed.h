#ifndef CHECK_SPEED_H
#define CHECK_SPEED_H

#include <QtWidgets>
#include "umeter.h"

class check_speed : public QFrame
{
    Q_OBJECT

public:
    explicit check_speed(QWidget *parent = 0);
    void setSpeedValue(int speed, int ch);
    QComboBox *pDeviceList;
    QPushButton *pButStart;

private:
    uMeter *ppMeter[2];
    QLCDNumber *ppLCD[2];
};

#endif // CHECK_SPEED_H
