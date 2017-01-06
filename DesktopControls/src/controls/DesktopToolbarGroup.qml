import QtQuick 2.7
import QtQuick.Layouts 1.1

import DesktopControls 0.1

Item {
    id: root
    implicitWidth:  actionRow.implicitWidth
    implicitHeight: 50 * Units.dp
    clip: true
    property alias container: repeater
    property var actions: []
    property var itemSpacing: 10 * Units.dp

    signal action(string id)

    RowLayout {
        id: actionRow
        anchors{
            top: parent.top
            bottom: parent.bottom
        }

        spacing: root.itemSpacing

        Repeater {
            id: repeater
            model: actions

            DesktopToolbarIconButton {
                implicitWidth: modelData.width
                implicitHeight: modelData.height

                text: modelData.text
                textColor: modelData.textColor
                tip: modelData.tip
                iconSource: modelData.iconSource
                iconSize: modelData.iconSize
                iconColor: modelData.iconColor ? modelData.iconColor : ""
                backgroundColor: modelData.backgroundColor ?
                                     modelData.backgroundColor : Theme.primaryColor
                visible: modelData.hasOwnProperty("visible") ? modelData.visible : true
                enabled: modelData.hasOwnProperty("enabled") ? modelData.enabled : true
                objectName: modelData.objectName
                hoverAnimation: modelData.hoverAnimation

                onClicked: root.action(objectName)
            }
        }

        Item{
            Layout.fillWidth: true
        }
    }
}
