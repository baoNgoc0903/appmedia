#include "qlistsongmodel.h"

QListSongModel::QListSongModel(QObject* parent): QAbstractListModel(parent){}

int QListSongModel::rowCount(const QModelIndex &parent) const
{
    do{
        (void)(parent);
    }while(0);

    return m_listsong.count();
}

QHash<int, QByteArray> QListSongModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TITLEROLE] = "titleofSong";
    roles[ARTISTROLE] = "artistofSong";
    roles[IMAGEROLE] = "imageofSong";
    roles[PATHROLE] = "pathofSong";
    return roles;
}

QVariant QListSongModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row()>= rowCount()){
        return QVariant();
    }
    return datafromIndex(index.row(), role);
}

QVariant QListSongModel::datafromIndex(const int& idx, const int& role) const
{
    QVariant value{QVariant::fromValue<QString>("")};
    switch(role){
    case QListSongModel::TITLEROLE:
        value = QVariant::fromValue<QString>(m_listsong.at(idx)._title);
        break;
    case QListSongModel::ARTISTROLE:
        value = QVariant::fromValue<QString>(m_listsong.at(idx)._artist);
        break;
    case QListSongModel::IMAGEROLE:
        value = QVariant::fromValue<QString>(m_listsong.at(idx)._image);
        break;
    case QListSongModel::PATHROLE:
        value = QVariant::fromValue<QString>(m_listsong.at(idx)._path);
        break;
    default:
        value = QVariant();
        break;
    }
    return value;
}

void QListSongModel::addSong(QString title, QString artist, QString image,QString path)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_listsong.append(Song(title,artist,image, path));
    endInsertRows();
    emit countChanged();
}

int QListSongModel::count(){
    return rowCount();
}
