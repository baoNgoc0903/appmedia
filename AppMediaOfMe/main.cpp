#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "player.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Player player;
    engine.rootContext()->setContextProperty("m_player", player.m_player);
    engine.rootContext()->setContextProperty("m_playlist", player.m_playlist);
    engine.rootContext()->setContextProperty("m_listmodel", player.m_listmodelSong);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
