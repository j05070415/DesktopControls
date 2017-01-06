import QtQuick 2.7
import QtQuick.Controls 2.0 as Controls
import DesktopControls 0.1

Item {
    id: root
    implicitWidth: 100
    implicitHeight: 34

    property string tip: ""
    property alias text: label.text
    property alias elide: label.elide
    property alias horizontalAlignment: label.horizontalAlignment
    property alias verticalAlignment: label.verticalAlignment
    function setValue(value) {
        label.text = String(value)
    }

    Label {
        id: label
        anchors.fill: parent
        elide: Text.ElideLeft
        verticalAlignment:Text.AlignVCenter
    }
}

