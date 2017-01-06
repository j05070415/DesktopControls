import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import DesktopControls 0.1 as Desktop

ComboBox {
    id: root
    implicitWidth: 100
    implicitHeight: 34
    style: ComboBoxStyle{
        background: Rectangle{
            anchors.fill: parent
            color: __control.pressed ? Qt.darker("white", 1.2) : "white"

            Icon{
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                backgroundColor: parent.color
                awesome: "angle_down"
                opacity: enabled ? 0.8 : 0.3
            }
        }
        font.family: Desktop.Theme.fontName
        font.pixelSize: Desktop.Theme.fontStyles[style1].size
    }

    property string style1: "body3"

    signal itemChanged(string id, var value)

    onActivated: {
        itemChanged(root.objectName, String(index))
    }

    function setValue(value) {
        currentIndex = Number(value)
    }
}
