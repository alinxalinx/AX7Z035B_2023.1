#ifndef ULABEL_H
#define ULABEL_H

#include <QtWidgets>

class uLabel    : public QLabel
{
public:
    uLabel(const QString &text="", QWidget *parent=0);

protected:
    void paintEvent(QPaintEvent *);
};

#endif // ULABEL_H
