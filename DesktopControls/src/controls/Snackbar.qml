
import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

import DesktopControls 0.1 as Desktop

/*!
   \qmltype Snackbar
   \inqmlmodule DesktopControls

   \brief Snackbars provide lightweight feedback about an operation
 */
Pane {
    id: snackbar

    property int duration: 2000

    function open(text) {
        snackText.text = text
        timer.restart()
    }

    anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
        bottomMargin: timer.running ? 0 :  -snackbar.height

        Behavior on bottomMargin {
            NumberAnimation { duration: 300 }
        }
    }

    background: Rectangle{
        color: "black"
    }

    Timer {
        id: timer

        interval: snackbar.duration
    }

    Desktop.Label {
        id: snackText
        anchors {
            fill: parent
            leftMargin: 24 * Desktop.Units.dp
            rightMargin: 24 * Desktop.Units.dp
        }

        Layout.fillWidth: true
        Layout.fillHeight: true
        verticalAlignment: Text.AlignVCenter
        maximumLineCount: 2
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        color: "white"
        style: "tooltip"
    }

    Behavior on opacity {
        NumberAnimation { duration: 300 }
    }
}
