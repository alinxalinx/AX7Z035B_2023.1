#-------------------------------------------------
#
# Project created by QtCreator 2018-01-30T17:01:57
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = pciespeed
TEMPLATE = app
DESTDIR = $$PWD/../__output
OBJECTS_DIR = $$PWD/../__build/pciespeed

SOURCES += main.cpp\
        main_window.cpp \
    check_speed.cpp \
    umeter.cpp \
    xdma_programe.cpp

HEADERS  += main_window.h \
    check_speed.h \
    umeter.h \
    xdma_programe.h


RC_FILE = myapp.rc
RESOURCES += img.qrc
LIBS += -lsetupapi
INCLUDEPATH += $$PWD/inc

