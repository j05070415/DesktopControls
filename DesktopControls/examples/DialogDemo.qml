import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

import DesktopControls 0.1 as Desktop

Item {
    Desktop.MessageDialog{
        id: dialog
        Rectangle{
            width: 100
            height: 100
            color: "red"
        }
        Rectangle{
            width: 100
            height: 100
            color: "red"
        }
        Rectangle{
            width: 100
            height: 100
            color: "red"
        }
        Rectangle{
            width: 100
            height: 100
            color: "red"
        }
        Rectangle{
            width: 100
            height: 100
            color: "red"
        }
    }

    Column{
        anchors.centerIn: parent
        Desktop.Button{
            text: "open1"
            onClicked: dialog.open()
        }
    }
}
