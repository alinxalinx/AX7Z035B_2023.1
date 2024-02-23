#-------------------------------------------------
#
# Project created by QtCreator 2018-01-30T17:01:57
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = screen2pcie
TEMPLATE = app
DESTDIR = $$PWD/../__output
OBJECTS_DIR = $$PWD/../__build/screen2pcie

SOURCES += main.cpp\
        main_window.cpp \
    set_capture.cpp \
    xdma_programe.cpp \
    capturescreen.cpp

HEADERS  += main_window.h \
    set_capture.h \
    xdma_programe.h \
    xdma_public.h \
    capturescreen.h

RC_FILE = myapp.rc
RESOURCES += img.qrc

LIBS += -lsetupapi
LIBS += -lws2_32
LIBS += -liphlpapi
LIBS += -lgdi32

