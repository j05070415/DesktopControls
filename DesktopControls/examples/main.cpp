#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material");
    QQmlApplicationEngine engine;
    QQuickView::setDefaultAlphaBuffer(true);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
