import QtQuick 2.7
import QtQuick.Controls.Material 2.0
import DesktopControls 0.1

Button {
    id: b

    hoverEnabled: true
    implicitWidth: 26 * Units.dp
    implicitHeight: 26 * Units.dp
    padding: 0
    property color backgroundColor: Theme.primaryColor
    background: Rectangle{
        anchors.fill: parent
        color: b.pressed ? Qt.darker(b.backgroundColor, 1.2) :
                   b.hovered ? Qt.lighter(b.backgroundColor, 1.2): b.backgroundColor
    }
}
