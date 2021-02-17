#ifndef QLISTSONGMODEL_H
#define QLISTSONGMODEL_H
#include <QAbstractListModel>
#include <QObject>
typedef struct Song{
    QString _name = "";
    QString _path = "";
    Song(QString name="", QString path=""): _name(name), _path(path){}
}Song;

class QListSongModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    explicit QListSongModel(QObject* parent = nullptr);
    friend class Player;
    enum SongRole:int{
        NAMEROLE = Qt::UserRole+1,
        PATHROLE
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant datafromIndex(const int& idx, const int& role) const;
    Q_INVOKABLE void addSong(QString name="", QString path="");
    int count();
signals:
    void countChanged();
private:
    QList<Song> m_listsong;
};

#endif // QLISTSONGMODEL_H
