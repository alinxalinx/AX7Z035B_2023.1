#ifndef UMETER_H
#define UMETER_H

#include <QtWidgets>

#define PI 3.1415926535

class uMeter : public QWidget
{
    Q_OBJECT
public:
    explicit uMeter(QWidget *parent = 0);
    int m_Angle;
    int m_maxValue;

protected:
    void paintEvent(QPaintEvent *event);

private:
    int speedStepMax;
signals:

public slots:
};

#endif // UMETER_H
