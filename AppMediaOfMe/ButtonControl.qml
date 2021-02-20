import QtQuick 2.0

Item {
    id: root
    property bool isBtnPlay: false
    property string icon_defalt: ""
    property string icon_pressed: ""
    property string icon_released: ""
    property alias source: img.source
    width: img.width
    height: img.height
    signal clicked
    Image{
        id: img
        source: icon_defalt
        width: isBtnPlay ? sourceSize.width-75:sourceSize.width-30
        height: isBtnPlay?sourceSize.height-75:sourceSize.height-30
        fillMode: Image.PreserveAspectFit
    }
    MouseArea{
        anchors.fill: parent
        onPressed: {
           img.source = icon_pressed
        }
        onReleased: {
            img.source = icon_released
        }
        onClicked: {
            root.clicked()
        }
    }
}
