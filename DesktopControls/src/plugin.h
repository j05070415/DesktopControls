#ifndef DESKTOPCONTROLS_PLUGIN_H
#define DESKTOPCONTROLS_PLUGIN_H

#include <QQmlExtensionPlugin>

class DesktopControlsPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "io.dotdot.desktop.controls")

public:
    void registerTypes(const char *uri);
};

#endif // DESKTOPCONTROLS_PLUGIN_H
