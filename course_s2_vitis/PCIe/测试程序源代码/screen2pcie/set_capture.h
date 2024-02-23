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

void task_ready(void);
void task_setWork(bool isRuning);
void *task_capture(void *);
void *task_xdma(void *);

#endif // SET_CAPTURE_H
