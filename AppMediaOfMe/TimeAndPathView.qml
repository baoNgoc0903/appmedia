import QtQuick 2.0
import QtQuick.Controls 2.12
Item {
    NumberAnimation{
        id: textChangeAni
        property: "opacity"
        from:0
        to:1
        duration: 400
        easing.type: Easing.InOutQuad
    }

    Text{
        id: title
        width: contentWidth
        anchors.top: parent.top
        anchors.topMargin: 13
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 18
        color: "white"
        text: m_listmodel.titleOfSong(idxOfListSong)
        onTextChanged: {
            textChangeAni.targets = [title, artist]
            textChangeAni.restart()
        }
    }
    Text{
        id: artist
        width: contentWidth
        anchors.top: title.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        font.pixelSize: 18
        color: "white"
        text: m_listmodel.artistOfSong(idxOfListSong)
    }

    Image{
        id:imgsong
        source: "qrc:/Image/music.png"
        anchors.top: parent.top
        anchors.topMargin: 13
        anchors.left: parent.right
        anchors.leftMargin: -46
        width: sourceSize.width-15
        height: sourceSize.height-15
        fillMode: Image.PreserveAspectFit
    }
    Text{
        id: countSong
        text: m_listmodel.count
        font.pixelSize: 20
        anchors.left: parent.right
        anchors.leftMargin: -17
        anchors.top: parent.top
        anchors.topMargin: 13
        color: "white"
    }
    Component {
        id: appDelegate

        Item {
            width: 400; height: 400
            scale: PathView.iconScale
            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: imageofSong
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    m_playlist.setCurrentIndex(index)
                }

            }
        }
    }
    Rectangle{
        anchors.left: parent.left
//        anchors.leftMargin: (parent.width - 1100)/2
        anchors.top: parent.top
//        anchors.topMargin: 300
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: "green"
        z:1111
        opacity: 0.3
    }

    PathView {
        id: album_art_view
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - 1100)/2
        anchors.top: parent.top
        anchors.topMargin: 300
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: m_listmodel
        delegate: appDelegate
        pathItemCount: 3
        currentIndex: m_playlist.currentIndex
        path: Path {
            startX: 10
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathLine { x: 550; y: 50 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: 1100; y: 50 }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
        onCurrentItemChanged : {
            m_playlist.setCurrentIndex(currentIndex)
            m_player.play()
        }
    }

    Text{
        id: positionTime
        width: contentWidth
        text: convertTime(m_player.position)
        color: "white"
        font.pixelSize: 15
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: 10
        anchors.left: parent.left
        anchors.leftMargin: 58
    }
    Text{
        id: totaltime
        width: contentWidth
        text: convertTime(m_player.duration)
        color: "white"
        font.pixelSize: 15
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: 10
        anchors.right: parent.right
        anchors.rightMargin: 58
    }
    Slider{
        id: slider
        from: 0
        to: m_player.duration
        value: m_player.position
        anchors.left: positionTime.right
        anchors.right: totaltime.left
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: 10
        background: Rectangle{
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight/2 - height/2
//            source: "qrc:/Image/progress_bar_bg.png"
            width: slider.availableWidth
            height: 4
            color: "black"
//            fillMode: Image.PreserveAspectFit

            Rectangle{
//                source: "qrc:/Image/progress_bar.png"
                width: slider.visualPosition*(slider.availableWidth-imgpoint.width/2) //slider.visualPosition*slider.availableWidth
                height: 4
                color: "white"
//                fillMode: Image.PreserveAspectFit
            }
        }
        handle: Image{
            id: imgpoint
            source: "qrc:/Image/point.png"
            x: slider.leftPadding + (slider.availableWidth -width)*slider.visualPosition
            y: slider.leftPadding + slider.availableHeight/2 - height/2
            width: sourceSize.width-5
            height: sourceSize.height-5
            fillMode: Image.PreserveAspectFit
            Image{
                source: "qrc:/Image/center_point.png"
                anchors.centerIn: parent
                width: sourceSize.width-5
                height: sourceSize.height-5
                fillMode: Image.PreserveAspectFit
            }
        }
        onMoved: {
            if (m_player.seekable){
                m_player.setPosition(slider.value)
            }
        }
        Connections{
            target: m_player
            function onPositionChanged(){
                sliani.targets = slider
                sliani.restart()
            }
        }
    }
    NumberAnimation{
        id: sliani
        property: "value"
        from: m_player.position
        to: m_player.position+1000
        duration: 1000
        easing.type: Easing.Linear
    }
    function convertTime(txt){
        var _hour = Math.floor(txt/3600000)
        var _minute = Math.floor((txt/1000)/60)
        var _second = Math.floor((txt/1000)%60)

        return _hour > 0? ((_hour>=10? _hour : "0"+_hour) + ":" +
                           (_minute>=10? _minute : "0"+_minute) + ":" +
                           (_second>=10? _second : "0"+_second))
                        : ((_minute>=10? _minute : "0"+_minute) + ":" +
                           (_second>=10? _second : "0"+_second))
    }
}
