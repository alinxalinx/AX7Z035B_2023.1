#include "ulabel.h"

uLabel::uLabel(const QString &text, QWidget *parent) :
    QLabel(text, parent)
{
}

void uLabel::paintEvent(QPaintEvent *)
{
    int px, py, pz = alignment();
    QPainter        painter(this);
    QPainterPath    path;

    QFont lfont = font();
    int fontWidth = lfont.pixelSize();
    int penWidth  = fontWidth*0.06;
    int currWidth;

    penWidth = penWidth/2*2;
    if(!penWidth)
    {
        penWidth = 1;
    }
    currWidth = fontWidth-(penWidth*4);

    lfont.setPixelSize(currWidth);
    QFontMetrics    metrics(lfont);

    if(pz & Qt::AlignLeft)
    {
        px = penWidth;
    }
    else if(pz & Qt::AlignRight)
    {
        px = width() - metrics.width(text()) - penWidth;
    }
    else
    {
        px = (width() - metrics.width(text())) / 2;
    }
    if(pz & Qt::AlignTop)
    {
        py = metrics.ascent();
    }
    else if(pz & Qt::AlignBottom)
    {
        py = height() - (metrics.height() - metrics.ascent());
    }
    else
    {
        py = (height() - metrics.height()) / 2 + metrics.ascent();
    }

    path.addText(px, py, lfont, text());
    painter.setRenderHint(QPainter::Antialiasing);
    painter.strokePath(path, QPen(Qt::black, penWidth));
    //painter.drawPath(path);
    painter.fillPath(path, QBrush(Qt::white));
}

