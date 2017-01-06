import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import DesktopControls 0.1 as Desktop

SpinBox {
    id: root
    implicitWidth: 100
    implicitHeight: 34

    editable: true
    stepSize: 100
    Material.accent: "blue"

    property string style: "body3"
    font.family: Desktop.Theme.fontName
    font.pixelSize: Desktop.Theme.fontStyles[style].size

    signal itemChanged(string id, var value)
    property int decimals: 2

    validator: DoubleValidator {
        decimals: root.decimals
        bottom: Math.min(root.from, root.to)
        top:  Math.max(root.from, root.to)
    }

    textFromValue: function(value, locale) {
        return Number(value / 100).toLocaleString(locale, 'f', root.decimals)
    }

    valueFromText: function(text, locale) {
        return Number.fromLocaleString(locale, text) * 100
    }

    function setValue(v) {
        value = Number(v)*100
    }

    onValueChanged: itemChanged(root.objectName, value/100.0)
}
