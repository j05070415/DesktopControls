import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import DesktopControls 0.1 as Desktop

SpinBox {
    id: root
    implicitWidth: 100
    implicitHeight: 34

    editable: true
    Material.accent: "blue"

    property string style: "body3"
    font.family: Desktop.Theme.fontName
    font.pixelSize: Desktop.Theme.fontStyles[style].size

    signal itemChanged(string id, var value)

    onValueChanged: itemChanged(root.objectName, value)

    function setValue(v) {
        value = Number(v)
    }
}
