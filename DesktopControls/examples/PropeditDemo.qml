import QtQuick 2.7

import DesktopControls 0.1

Item {
    TemplateViewer{
        id: editor
        width: 400
        height: parent.height

        onItemChanged: print(id+","+value)
    }

    Row{
        anchors.left: editor.right
        Button{
            text:"add"
            onClicked: {
                var json = {
                                "role":["node_type"],
                                "node_type":"FC_ROOT",
                                "name":"FC卡",
                                "card_id":"0",
                                "baud_rate":"1",
                                "is_login_switch":"1"
                            }
                editor.create("qrc:/TemplateDemo.qml")
                editor.updateContent(json)
            }
        }

        Button{
            text:"clear"
            onClicked: {
                editor.clear()
            }
        }

        Button{
            text:"Snack"
            onClicked: {
                snack.open("Snack")
            }
        }
    }
}
