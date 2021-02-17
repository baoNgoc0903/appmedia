#ifndef PLAYER_H
#define PLAYER_H
#include <QObject>
#include <QDirIterator>
#include <qlistsongmodel.h>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QDebug>
class Player: public QObject
{
    Q_OBJECT
public:
    explicit Player(QObject* parent = nullptr);
    void openBrower();
public:
    QListSongModel* m_listmodelSong;
    QMediaPlayer* m_player;
    QMediaPlaylist* m_playlist;
};

#endif // PLAYER_H
