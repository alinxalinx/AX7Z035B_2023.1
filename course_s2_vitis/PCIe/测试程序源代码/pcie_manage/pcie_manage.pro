#-------------------------------------------------
#
# Project created by QtCreator 2018-01-30T17:01:57
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = pcie_manage
TEMPLATE = app
DESTDIR = $$PWD/../__output
OBJECTS_DIR = $$PWD/../__build/pcie_manage

SOURCES += main.cpp\
        main_window.cpp \
    xdma_programe.cpp \
    user_ui.cpp \
    pcie_manage.cpp

HEADERS  += main_window.h \
    xdma_programe.h \
    xdma_public.h \
    user_ui.h \
    pcie_manage.h

RC_FILE = myapp.rc
RESOURCES += img.qrc

LIBS += -lsetupapi
LIBS += -lws2_32
LIBS += -liphlpapi
LIBS += -lgdi32
DEFINES += STRSAFE_NO_DEPRECATE

