import QtQuick 2.0

Item {
    id: root
    property bool volume: false // tại image volume to
    property string icon_on: ""
    property string icon_off: ""
    property bool state: false
    // k c
    width: img.width
    height: img.height
    Image{
        id: img
        // có nhảy lại vào source chạy lại hàm load lại source
        source: /*root.state?icon_on : icon_off*/{
            if(root.state){
                console.log(root.state)
                return icon_on
            }
            else{
                console.log(root.state)
                return icon_off
            }
        }
        width: !volume?sourceSize.width-20:sourceSize.width-50
        height: !volume?sourceSize.height-20:sourceSize.height-50
        opacity: !volume?1.0 : 0.7
        fillMode: Image.PreserveAspectFit
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            root.state = !root.state
        }
    }
}
