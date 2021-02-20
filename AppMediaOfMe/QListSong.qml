import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    NumberAnimation{
        id: changeAni
        property: "opacity"
        from: 0
        to:1
        duration: 400
        easing.type: Easing.InOutQuad
    }

    ListView{
        id: listview
        anchors.fill: parent
        orientation: ListView.Vertical
        clip: true
        spacing: 2
        focus: true
        model: m_listmodel
        currentIndex: m_playlist.currentIndex
        delegate: Item{
            width: parent.width
            height: 96
            Image{
                id:imgplaying
                anchors.left: parent.left
                anchors.verticalCenter: parent.bottom
                anchors.verticalCenterOffset: -83/2
                width: sourceSize.width-10
                height: sourceSize.height-10
                fillMode: Image.PreserveAspectFit
                source: listview.currentIndex ===index?"qrc:/Image/playing.png":""
            }

            Image{
                id: itemImage
                anchors.fill: parent
                source:"qrc:/Image/playlist.png"
            }
            Text{
                id: txt
                width: contentWidth
                anchors.verticalCenter: parent.bottom
                anchors.verticalCenterOffset: -83/2
                anchors.left:  parent.left
                anchors.leftMargin:listview.currentIndex ===index?(imgplaying.width+5):5
                font.pixelSize: 20
                color: "white"
                text: titleofSong
            }
            Text{
                id: txt1
                width: contentWidth
                anchors.verticalCenter: parent.bottom
                anchors.verticalCenterOffset: -83/2
                anchors.left:  txt.right
                anchors.leftMargin:0
                font.pixelSize: 20
                color: "white"
                text: " - "+ artistofSong
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    m_playlist.setCurrentIndex(index)
                }

                onPressed: {
                    itemImage.source = "qrc:/Image/hold.png"
                }
                onReleased: {
                    itemImage.source = 'qrc:/Image/playlist.png'
                }
            }
        }
        ScrollBar.vertical: ScrollBar{
            parent: listview.parent
            anchors.top: listview.top
            anchors.bottom: listview.bottom
            anchors.left: listview.right
        }
        highlight: Image{
            width: parent.width
            source: "qrc:/Image/playlist_item.png"
            height: 96
        }
        /* muốn chơi nhạc thì phải setCurrentIndex, sau đó gọi play
           tỷ như khi click button next, thì next <=> setCurrentIndex rồi, chỉ cần
           play nữa thôi, nhưng khi dùng phím mũi tên ấy, chưa hề có thao tác setCurrentIndex
           nên ở itemChanged phải có cho trường hợp đó*/
        onCurrentItemChanged: {
            m_playlist.setCurrentIndex(currentIndex) // focus -for phím mũi tên
            m_player.play()
            changeAni.targets = [listview.currentItem]
            changeAni.restart()
        }
    }
}
