import QtQuick 2.0
import QtMultimedia 5.12
import QtQuick.Controls 2.0
Item {
    ButtonSwitch{
        id: shuffer
        anchors.left: parent.left
        anchors.leftMargin: 58
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: 45
        icon_on: "qrc:/Image/shuffle-1.png"
        icon_off: "qrc:/Image/shuffle.png"
        onStateChanged: {
            if(repeater.state){
            }
            else{
                if(shuffer.state){
//                    m_playlist.setCurrentIndex(ishuffer()) // có hàm này thì khi nhấn nó sẽ shuffer 1 cái tức thì, k đúng lắm
                    if(m_playlist.currentIndex === m_listmodel.count-1){
                        m_playlist.playbackMode = 2
                    }
                    else{
                        m_playlist.playbackMode = 4 // ntn là hết bài nó sẽ shuffer, quan trọng là playbackMode của list
                    }
                }
                else{
                    m_playlist.playbackMode = 2
                }
            }
        }
    }
    //k cần
//    function ishuffer(){
//        console.log("shuffer")
//        var newIndex = Math.floor(Math.random()*m_listmodel.count)
//        while(newIndex ===m_playlist.currentIndex){
//            newIndex = Math.floor(Math.random()*m_listmodel.count)
//        }
//        return newIndex
//    }

    ButtonSwitch{
        id:repeater
        anchors.right: parent.right
        anchors.rightMargin: 58
        anchors.verticalCenter: shuffer.verticalCenter
        icon_on: "qrc:/Image/repeat1_hold.png"
        icon_off: "qrc:/Image/repeat.png"
        onStateChanged: {
            if(repeater.state){
                m_playlist.playbackMode = 1
            }
            else{
                m_playlist.playbackMode = 2
            }
        }
    }
    ButtonControl{
        id: btnprev
        anchors.right: btnplay.left
        anchors.verticalCenter: shuffer.verticalCenter
        icon_defalt: "qrc:/Image/prev.png"
        icon_pressed: "qrc:/Image/hold-prev.png"
        icon_released: "qrc:/Image/prev.png"
        onClicked: {
            if(m_playlist.currentIndex === 0){
                m_playlist.setCurrentIndex(m_listmodel.count - 1)
            }
            else if(repeater.state){
                m_playlist.playbackMode = 2
                if(shuffer.state){
                    m_playlist.playbackMode = 4 // ntn khi next nó ưu tiên shuffer
                }
                m_playlist.previous()
                m_playlist.playbackMode = 1
            }
            else{
                m_playlist.previous()
            }
        }
    }
    ButtonControl{
        id: btnplay
        isBtnPlay: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: shuffer.verticalCenter
        property bool isPlay: m_player.state === MediaPlayer.PlayingState
        icon_defalt: /*isPlay? "qrc:/Image/pause.png":"qrc:/Image/play.png"*/{
            if(isPlay){
                console.log(1)
                return "qrc:/Image/pause.png"
            }
            else{
                console.log(2)
                return "qrc:/Image/play.png"
            }
        }

        icon_pressed:isPlay? "qrc:/Image/hold-pause.png" : "qrc:/Image/hold-play.png"
        icon_released: isPlay?"qrc:/Image/play.png": "qrc:/Image/pause.png"
        onClicked: {
            if(isPlay){
                m_player.pause()
            }
            else{
                m_player.play()
            }
        }
        Connections{
            target: m_player
            function onStateChanged(){
                if(m_player.state === MediaPlayer.PlayingState){
                    console.log("play")
                    btnplay.source = "qrc:/Image/pause.png"
                }
            }
        }
    }
    ButtonControl{
        id: btnnext
        anchors.left: btnplay.right
        anchors.verticalCenter: shuffer.verticalCenter
        icon_defalt: "qrc:/Image/next.png"
        icon_pressed: "qrc:/Image/hold-next.png"
        icon_released: "qrc:/Image/next.png"
        onClicked: {
            if(m_playlist.currentIndex === m_listmodel.count-1){
                m_playlist.setCurrentIndex(0)
            }
            else if(repeater.state){
                m_playlist.playbackMode = 2
                if(shuffer.state){
                    m_playlist.playbackMode = 4
                }
                m_playlist.next()
                m_playlist.playbackMode = 1 // k next được
            }
            else{
                m_playlist.next()
            }
        }
    }
    Slider{
        id: slider
        width: 200
        from: 0
        to: 100
        value: m_player.volume
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: -20
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
                m_player.setVolume(slider.value)
            }
        }
    }
    ButtonSwitch{
        id: btnvolume
        volume: true
        anchors.verticalCenter: slider.verticalCenter
        anchors.right: slider.left
        anchors.rightMargin: 10
        state: true
        icon_on: "qrc:/Image/volumeup_white.png"
        icon_off: "qrc:/Image/volumeoff_white.png"
        onStateChanged: {
            if(btnvolume.state){
                m_player.setMuted(false)
            }
            else{
                m_player.setMuted(true)
            }
        }
    }
}
