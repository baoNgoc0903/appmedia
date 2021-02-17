import QtQuick 2.0

Item {
    id: root
    Image{
        source: "qrc:/Image/title.png"
        width: parent.width
        height: parent.height
    }
    Text{
        anchors.left: parent.left
        anchors.leftMargin: 347+70
        anchors.top: parent.top
        anchors.topMargin: 28
        font.pixelSize: 25
        color: "white"
        text:"Media Player"
    }
}
