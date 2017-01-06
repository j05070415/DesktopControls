TEMPLATE = lib
QT += qml quick
CONFIG += qt plugin c++11 qtquickcompiler

uri = com.hwa.qmlcomponents

win32:{
    LIBS += -L"C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Lib"
    INCLUDEPATH += "C:/Program Files (x86)/Microsoft SDKs/Windows/v7.1A/Include"
}

CONFIG(debug, debug|release) {
    TARGET = DesktopControlsd
} else {
    TARGET = DesktopControls
}

# Input
SOURCES += \
    plugin.cpp \
    core/device.cpp \
    core/units.cpp \
    model/TreeItem.cpp \
    model/TreeModel.cpp

RESOURCES += \
            $$PWD/core/core.qrc \
            $$PWD/components/components.qrc         \
            $$PWD/controls/controls.qrc             \
            $$PWD/property_edit/property_edit.qrc  \
            $$PWD/../icons/icons.qrc

HEADERS += \
    plugin.h \
    core/device.h \
    core/units.h \
    model/TreeItem.h \
    model/TreeModel.h

target.path = $$[QT_INSTALL_QML]/DesktopControls
desktopcontrols.path = $$[QT_INSTALL_QML]/DesktopControls
desktopcontrols.files = qmldir

INSTALLS += target desktopcontrols
