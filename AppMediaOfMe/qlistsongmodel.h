#ifndef QLISTSONGMODEL_H
#define QLISTSONGMODEL_H
#include <QAbstractListModel>
#include <QObject>
typedef struct Song{
    QString _title = "";
    QString _artist = "";
    QString _image = "";
    QString _path = "";
    Song(QString title="",QString artist="", QString image="", QString path=""):
        _title(title), _artist(artist),_image(image), _path(path){}
}Song;

class QListSongModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    Q_INVOKABLE QString titleOfSong(int idx){
        return m_listsong.at(idx)._title;
    }
    Q_INVOKABLE QString artistOfSong(int idx){
        return m_listsong.at(idx)._artist;
    }
public:
    explicit QListSongModel(QObject* parent = nullptr);
    friend class Player;
    enum SongRole:int{
        TITLEROLE = Qt::UserRole+1,
        ARTISTROLE,
        IMAGEROLE,
        PATHROLE
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant datafromIndex(const int& idx, const int& role) const;
    Q_INVOKABLE void addSong(QString title="",QString artist="",QString image="", QString path="");
    int count();
signals:
    void countChanged();
private:
    QList<Song> m_listsong;
};

#endif // QLISTSONGMODEL_H
