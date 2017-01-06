TEMPLATE = app
QT += qml quick quickcontrols2

CONFIG += c++11 qtquickcompiler

win32:{
    LIBS += -L"C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Lib"
    INCLUDEPATH += "C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Include"
}

SOURCES += main.cpp

RESOURCES +=  $$PWD/../icons/icons.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = qml

# Default rules for deployment.
include(deployment.pri)
