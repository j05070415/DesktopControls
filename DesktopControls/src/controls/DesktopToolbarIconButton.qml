import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import DesktopControls 0.1 as Desktop

DesktopButton{
    id: button

    implicitWidth: iconSize
    implicitHeight: iconSize
    opacity: enabled ? 1 : 0.6
    property string tip: ""
    property string textColor: "grey"
    property int iconSize: 30 * Desktop.Units.dp
    property string iconName
    property string iconSource: iconName ?
                                    "qrc:/icons/" + iconName + ".svg" : ""
    property bool hoverAnimation: false

    property alias iconColor: icon.iconColor

    contentItem: Item{
        anchors.fill: parent
        anchors.bottomMargin: label.visible ? 3 : 0
        Icon {
            id: icon
            anchors{
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: label.visible ? label.top : parent.bottom
            }
            backgroundColor: button.backgroundColor

            source: button.iconSource
            size: button.iconSize
            rotation: button.hoverAnimation ?
                          hovered ? 90 : 0 : 0

            Behavior on rotation {
                NumberAnimation { duration: 200 }
            }
        }

        Desktop.Label {
            id: label
            height: button.height/3
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            verticalAlignment: Text.AlignVCenter
            visible: text

            style: "button"
            color: button.textColor
            text: button.text
        }
    }

    ToolTip.delay: 1000
    ToolTip.timeout: 500
    ToolTip.visible: button.tip && button.hovered
    ToolTip.text: button.tip
}
