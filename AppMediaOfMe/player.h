#ifndef PLAYER_H
#define PLAYER_H
#include</home/zg0c/appmedia/AppMediaOfMe/Taglib_FileHeader/id3v2tag.h> // don't need when add INCLUDE in .pro file
#include<mpegfile.h>
#include<id3v2frame.h>
#include<id3v2header.h>
#include <attachedpictureframe.h>
#include <tag.h>
#include<cstdio>
#include<string.h>
#include <QObject>
#include <QStandardPaths>
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
    ~Player();
    void openBrower();
    void addToPlayList(QString path="", QString name="");
    QString getAlbumArt(TagLib::MPEG::File& mpegFile, QString name="");
    void removeFile();
public:
    QListSongModel* m_listmodelSong;
    QMediaPlayer* m_player;
    QMediaPlaylist* m_playlist;
};

#endif // PLAYER_H
