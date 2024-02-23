#-------------------------------------------------
#
# Project created by QtCreator 2018-01-30T17:01:57
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = pcie2screen
TEMPLATE = app
DESTDIR = $$PWD/../__output
OBJECTS_DIR = $$PWD/../__build/pcie2screen

SOURCES += main.cpp\
        main_window.cpp \
    set_capture.cpp \
    xdma_programe.cpp \
    opengl_yuv.cpp \
    ulabel.cpp

HEADERS  += main_window.h \
    set_capture.h \
    xdma_programe.h \
    xdma_public.h \
    opengl_yuv.h \
    ulabel.h

RC_FILE = myapp.rc
RESOURCES += img.qrc
DEFINES += STRSAFE_NO_DEPRECATE

LIBS += -lsetupapi


