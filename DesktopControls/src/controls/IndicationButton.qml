import QtQuick 2.7
import QtQuick.Controls 2.0
import DesktopControls 0.1

ItemDelegate{
    id: root
    implicitWidth: 80
    implicitHeight: 27
    property color backgroundColor: "black"
    contentItem: Label {
        id: label
        // @disable-check M16
        anchors.fill: parent
        // @disable-check M16
        backgroundColor: root.backgroundColor
        horizontalAlignment: Text.AlignHCenter
        text: root.text
    }
    hoverEnabled: true
    background: Rectangle{
        color: parent.hovered ?
                   parent.pressed ?
                       Qt.darker(root.backgroundColor,1.2) :
                       Qt.lighter(root.backgroundColor,0.8) :
        root.backgroundColor
        Rectangle{
            id: indicator
            anchors.bottom: parent.bottom
            width: parent.width
            color: Theme.accentColor
            height: 3

            Behavior on width {
                NumberAnimation {
                    easing.type: Easing.OutCubic
                    duration: 240
                }
            }
        }
    }
    state: "Quit"
    states: [
        State {
            name: "Enter"
            PropertyChanges {
                target: indicator
                width: background.width; height: 3
            }
        },
        State {
            name: "Quit"
            PropertyChanges {
                target: indicator
                width: 0
            }
            PropertyChanges {
                target: indicator
                width: 0;height: 0
            }
        }
    ]
}
