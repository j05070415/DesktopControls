import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import DesktopControls 0.1 as Desktop

TextField {
    id: root
    implicitWidth: 100
    implicitHeight: 40

    property string previous: ""
    selectByMouse: true

    signal itemChanged(string id, var value)

    onAccepted: {
        if (text != previous) {
            itemChanged(root.objectName, text)
            previous = text
        }
        focus = false
    }

    property string style: "body3"
    color: "black"
    font.family: Desktop.Theme.fontName
    font.pixelSize: Desktop.Theme.fontStyles[style].size

    function setValue(value) {
        text = String(value)
    }
}
