#include "umeter.h"

uMeter::uMeter(QWidget *parent)
    : QWidget(parent)
{
    speedStepMax = 10;
    m_Angle = -210;
    m_maxValue = 1000;
    setStyleSheet("font-size:6px;");
}

void uMeter::paintEvent(QPaintEvent *)
{
    int diameter;
    QPainter painter(this);

    painter.setRenderHint(QPainter::Antialiasing, true);

    diameter = qMin(width(), height());
    painter.setViewport((width() - diameter) / 2, (height() - diameter) / 2, diameter, diameter);
    painter.setWindow(-50, -50, 100, 100);

    //背景
    painter.setBrush(QColor(Qt::black));
    painter.drawEllipse(-45, -45, 90, 90);

    //
    QLinearGradient linearGrad(QPointF(-15, -45), QPointF(90, 75));
    linearGrad.setColorAt(0, QColor(255,255,255,30));
    linearGrad.setColorAt(0.3, QColor(120,120,120,20));
    QBrush brush = QBrush(linearGrad);
    QPen pen;
    pen = QColor(0,0,0,0);
    pen.setBrush(brush);
    pen.setWidth(1);
    painter.setPen(pen);
    painter.setBrush(brush);
    painter.drawEllipse(-45,-45,90,90);


    //刻度图标
    int startAngle = 210;
    int endAngle = -30;
    painter.save();
    pen = QPen(QColor(Qt::white));
    pen.setWidth(0);
    painter.setPen(pen);
    painter.rotate(-startAngle) ;
    double angleStep=(-endAngle+startAngle)/speedStepMax;
    for ( int i=0; i<=speedStepMax;i++ )
    {
        painter.drawLine(28,0,30,0 );
        painter.rotate(angleStep/1 );
    }
    painter.restore();

    pen.setWidth(0);
    painter.setPen(pen);
    double spanAngle=endAngle-startAngle;
    painter.drawArc(-28,-28,56,56, startAngle*16, spanAngle*16);


    //刻度数字
    int m_minValue = 0;
    int m_precision = 0;
    painter.save();
    painter.setPen(QColor(Qt::white));
    double startRad=startAngle*PI/180.0;
    startRad+=PI/2;
    double deltaRad=(endAngle-startAngle)/(speedStepMax)*(PI/180);
    double sina,cosa;
    for ( int i=0; i<=speedStepMax; i++ )
    {
        sina=sin((double)(startRad+i*deltaRad));
        cosa=cos((double)(startRad+i*deltaRad));
        double tmpVal=i*((m_maxValue-m_minValue)/speedStepMax);
        tmpVal+=m_minValue;
        QString str = QString( "%1" ).arg(tmpVal,0,'f',m_precision);
        QFontMetricsF fm( this->font() );
        double w=fm.size(Qt::TextSingleLine,str).width();
        double h=fm.size(Qt::TextSingleLine,str).height();
        int x=(int)((38*sina)-(w/2));
        int y=(int)((38*cosa)+(h/4));
        painter.drawText(x,y,str);
    }
    painter.restore();

    painter.save();
    double thresholdAngle = ( startAngle+(endAngle-startAngle)/(m_maxValue-m_minValue)*(21-m_minValue) );
    pen.setWidth(3);

    pen.setColor(Qt::green);
    painter.setPen(pen);
    painter.drawArc(-25,-25,50,50,(int)(startAngle-2)*16,(int)(-thresholdAngle+endAngle+4)*16);
    painter.restore();


    //银色的边框
    painter.save();
    QRectF rectangle(-47, -47, 94, 94);
    startAngle = 30 * 16;
    spanAngle = 390 * 16;
    brush=QBrush(QColor(200,200,200));
    pen.setBrush(brush);
    pen.setWidth(2);
    painter.setPen(pen);
    painter.drawArc(rectangle, startAngle, spanAngle);
    painter.restore();

    painter.setPen(QColor(Qt::white));
    painter.setBrush(QColor(Qt::white));
    painter.setPen(QColor(Qt::white));
    QRectF labelRect=QRectF(-15,-20,30,10);
    painter.drawText(labelRect,Qt::AlignCenter, "MB/s");

    //指针
    painter.save();
    painter.rotate(-90.0);
    QPolygon pts;
    pts.setPoints( 3, -2,0,  2,0,  0,30 );
    QPolygon shadow;
    shadow.setPoints(3, -1,0, 1,0, 0,29);

    painter.rotate( m_Angle );
    QRadialGradient haloGradient(0, 0, 20, 0, 0);
    haloGradient.setColorAt(0.0, QColor(255,120,120));
    haloGradient.setColorAt(1.0, QColor(200,20,20));
    QColor color=QColor(Qt::darkRed);
    color.setAlpha(90);
    painter.setPen(color);
    painter.setBrush(haloGradient);
    painter.drawConvexPolygon( pts );

    painter.setBrush(QColor(255,120,120));
    painter.drawConvexPolygon( shadow );

    painter.restore();

    // draw needle hat
    QLinearGradient linearGrad02(QPointF(-7, -7), QPointF(14, 14));
    linearGrad02.setColorAt(0, Qt::white);
    linearGrad02.setColorAt(1, Qt::black);
    painter.setPen(Qt::NoPen);
    painter.setBrush(linearGrad02);
    painter.drawEllipse(-7, -7, 14, 14);
}
