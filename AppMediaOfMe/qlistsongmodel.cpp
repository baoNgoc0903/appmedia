#include "qlistsongmodel.h"

QListSongModel::QListSongModel(QObject* parent): QAbstractListModel(parent)
{
}

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
    roles[NAMEROLE] = "nameofSong";
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
    case QListSongModel::NAMEROLE:
        value = QVariant::fromValue<QString>(m_listsong.at(idx)._name);
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

void QListSongModel::addSong(QString name, QString path)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_listsong.append(Song(name, path));
    endInsertRows();
    emit countChanged();
}

int QListSongModel::count(){
    return rowCount();
}
