import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
ApplicationWindow{
    visible: true
    width: 980
    height: 611
    title: qsTr("Fresher")
    Button{
        text: "click"
        z:11111
        onClicked: {
            m_listmodel.addSong("123", "12312")
        }
    }

    Image{
        id: background
        source: "qrc:/Image/background.png"
    }
    QTopBar{
        id: topbar
        width: parent.width
        height: 72
    }
    QListSong{
        id:listview
        anchors.top: topbar.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 347
    }
    ControlNodes{
        id:controlnoes
        anchors.left: listview.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 150
    }
    TimeAndPathView{
        id: timeandpathview
        anchors.left: listview.right
        anchors.bottom: controlnoes.top
        anchors.right: parent.right
        anchors.top: topbar.bottom
    }
}