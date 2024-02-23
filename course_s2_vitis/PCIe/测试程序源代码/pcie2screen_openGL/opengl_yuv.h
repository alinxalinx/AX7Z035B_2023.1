#ifndef OPENGL_YUV_H
#define OPENGL_YUV_H

#include <QtWidgets>
#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QOpenGLBuffer>
#include <QOpenGLShaderProgram>
#include <QOpenGLTexture>
#include "ulabel.h"

#define ATTRIB_VERTEX   3
#define ATTRIB_TEXTURE  4

QT_FORWARD_DECLARE_CLASS(QOpenGLShaderProgram)
QT_FORWARD_DECLARE_CLASS(QOpenGLTexture)


class uOpenglYuv : public QOpenGLWidget, protected QOpenGLFunctions
{
    Q_OBJECT

public:
    explicit uOpenglYuv(QWidget *parent = 0);
    QTreeWidgetItem *pItem;
    ~uOpenglYuv();
    pthread_mutex_t optnotice;

protected:
    void initializeGL() Q_DECL_OVERRIDE;
    void paintGL() Q_DECL_OVERRIDE;
    void mousePressEvent(QMouseEvent *);
    void mouseReleaseEvent(QMouseEvent *);
    void mouseDoubleClickEvent(QMouseEvent *);
    void mouseMoveEvent(QMouseEvent *);

private:
    QOpenGLShaderProgram *m_program;


    unsigned long long a;
    unsigned long long frameCot = 0;
    struct timeval last_time;
    struct timeval curr_time;

public:
    unsigned short vW, vH;
    unsigned char *pRGB;

    GLuint textureRGB;
    GLuint TextureID0;

Q_SIGNALS:
    void mouseDoubleClickNotice(int);
    void flushFps(int);
};

#endif // OPENGL_YUV_H
