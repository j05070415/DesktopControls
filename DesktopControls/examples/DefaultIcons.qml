import QtQuick 2.0
import DesktopControls 0.1

Rectangle {
    AwesomeIcon{
        id: icons
    }

    Flickable{
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.fill: parent
        clip: true
        contentHeight: layer.implicitHeight

        Flow{
            id: layer
            anchors.fill: parent
            spacing: 15
            Repeater{
                model: Object.keys(icons.icons)
                Column{
                    width: 170
                    AwesomeIcon{
                        anchors.horizontalCenter: parent.horizontalCenter
                        name: modelData
                    }
                    Label{
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: modelData
                    }
                }
            }
        }
    }
}
