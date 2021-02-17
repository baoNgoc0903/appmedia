#include "player.h"

Player::Player(QObject* parent): QObject(parent)
{
    m_listmodelSong = new QListSongModel(this);
    m_player = new QMediaPlayer(this);
    m_playlist = new QMediaPlaylist(this);

    m_player->setPlaylist(m_playlist);
    openBrower();

    for(int i = 0; i<m_listmodelSong->m_listsong.count(); i++){
        bool check = m_playlist->addMedia(QUrl::fromLocalFile(m_listmodelSong->m_listsong.at(i)._path));
        qDebug() << check;
    }
    if(!m_playlist->isEmpty()){
        m_playlist->setCurrentIndex(0);
    }
    m_playlist->setPlaybackMode(QMediaPlaylist::Sequential);
//    m_player->play(); // code dưới c chạy trước, nên chỗ này nó play trước, sau đó qml bật lên chạy vào itemchanged ở listview làm nó play lại 1 lần nữa
    m_player->setVolume(20);
}

void Player::openBrower()
{
    QString root = "/home/baongoc/AppMediaOfMe/Song";
    QDirIterator it(root, QStringList()<<"*.mp3", QDir::Files, QDirIterator::Subdirectories);
    while(it.hasNext()){
        it.next();
        m_listmodelSong->addSong(it.fileName(), it.filePath());
    }
}
