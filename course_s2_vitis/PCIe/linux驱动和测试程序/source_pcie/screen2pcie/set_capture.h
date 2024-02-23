#ifndef SET_CAPTURE_H
#define SET_CAPTURE_H

#include <QtWidgets>

class set_capture : public QFrame
{
    Q_OBJECT
public:
    explicit set_capture(QWidget *parent = 0);

    QPushButton *pButStart;

signals:

public slots:
};

extern bool working;
void *task_xdma(void *);

#endif // SET_CAPTURE_H
