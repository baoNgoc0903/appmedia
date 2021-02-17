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
        width: isBtnPlay ? sourceSize.width-55:sourceSize.width-20
        height: isBtnPlay?sourceSize.height-55:sourceSize.height-20
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
