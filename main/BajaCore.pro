#-------------------------------------------------
#
# Project created by QtCreator 2018-10-26T08:59:07
#
#-------------------------------------------------

QT       += core gui charts qml quick

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = BajaCore
TEMPLATE = app

LIBS += -lQt5Charts

QMAKE_CXXFLAGS += -mthumb
QMAKE_CXXFLAGS += -mthumb-interwork


# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++11

SOURCES += \
        BajaCore.py \


RESOURCES += \
    resources.qrc

OTHER_FILES += \
    qml/dashboard.qml \
    qml/ValueSource.qml \
    qml/DashboardGaugeStyle.qml \
    qml/loadingScreen.qml
    #images/Background.png

HEADERS += \
        mainwindow.h

# Default rules for deployment.
#qnx: target.path = /tmp/$${TARGET}/bin
#else: unix:!android: target.path = /opt/$${TARGET}/bin
#!isEmpty(target.path): INSTALLS += target

RESOURCES += \
    resources.qrc

DISTFILES += \
    BajaCore.py \
    qml/dashboard.qml \
    qml/DashboardGaugeStyle.qml \
    qml/ValueSource.qml \
    qml/loadingScreen.qml
    #images/Background.png

