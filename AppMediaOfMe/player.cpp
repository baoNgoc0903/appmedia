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

Player::~Player()
{
    removeFile();
    qDebug() <<"Destroy player instance";
}
void Player::openBrower()
{
    QString root = "/home/zg0c/appmedia/AppMediaOfMe/Song";
    QDirIterator it(root, QStringList()<<"*.mp3", QDir::Files, QDirIterator::Subdirectories);

    while(it.hasNext()){
        it.next();
        addToPlayList(it.filePath(), it.fileName());
    }
}
void Player::removeFile()
{
    QString root = "/home/zg0c/appmedia/AppMediaOfMe/ImageSinger";
    QDirIterator it(root, QStringList()<<"*.jpg" << "*.png", QDir::Files, QDirIterator::Subdirectories);
    while(it.hasNext()){
        it.next();
        QFile::remove(it.filePath());
    }
}

void Player::addToPlayList(QString path, QString name)
{
    TagLib::MPEG::File mpegFile(path.toStdString().c_str());
    TagLib::Tag* tag = mpegFile.tag();
    m_listmodelSong->addSong(QString::fromWCharArray(tag->title().toCWString()),
                             QString::fromWCharArray(tag->artist().toCWString()),
                             getAlbumArt(mpegFile,name), path);
}

QString Player::getAlbumArt(TagLib::MPEG::File &mpegFile, QString name)
{
    static const char *IdPicture = "APIC" ;

    TagLib::ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
    TagLib::ID3v2::FrameList Frame ;
    TagLib::ID3v2::AttachedPictureFrame *PicFrame ;
    void *SrcImage ;
    unsigned long Size ;
    QString root = "/home/zg0c/appmedia/AppMediaOfMe/ImageSinger/";
    if ( id3v2tag )
    {
        // picture frame
        Frame = id3v2tag->frameListMap()[IdPicture] ;
        if (!Frame.isEmpty() )
        {
            for(TagLib::ID3v2::FrameList::ConstIterator it = Frame.begin(); it != Frame.end(); ++it)
            {
                PicFrame = static_cast<TagLib::ID3v2::AttachedPictureFrame*>(*it) ;
                if ( PicFrame->type() == TagLib::ID3v2::AttachedPictureFrame::FrontCover)
                {
                    TagLib::String exFile = PicFrame->mimeType();
                    FILE *fileImg;
                    if(exFile == "image/jpeg")
                    {
                        fileImg = fopen(QString(root+name+".jpg").toStdString().c_str(),"wb");
                    }
                    else if(exFile == "image/png"){
                        fileImg = fopen(QString(root+name+".png").toStdString().c_str(),"wb");
                    }
                    else{
                        return "qrc:/Image/album_art.png";
                    }

                    // extract image (in it’s compressed form)
                    Size = PicFrame->picture().size() ;
                    SrcImage = malloc ( Size ) ;
                    if ( SrcImage )
                    {
                        memcpy ( SrcImage, PicFrame->picture().data(), Size ) ;
                        fwrite(SrcImage,Size,1, fileImg);
                        fclose(fileImg);
                        free( SrcImage ) ;
                        if(exFile == "image/jpeg"){
                           return QUrl::fromLocalFile(root+name+".jpg").toDisplayString();
                        }
                        else if(exFile == "image/png"){
                            return QUrl::fromLocalFile(root+name+".png").toDisplayString();
                        }
                    }
                }
            }
        }
    }
    else
    {
        qDebug() <<"id3v2 not present";
        return "qrc:/Image/album_art.png";
    }
    return "qrc:/Image/album_art.png";
}
