import QtQuick 2.0
import QtQuick.Controls 2.0
import DesktopControls 0.1

Frame {
    function updateContent(c){
        Object.keys(map).forEach(function(k){
            if (c.hasOwnProperty(k)) {
                map[k].setValue(c[k])
            }
        })
    }

    property var map: {
        "name": card,
                "card_id":cardNumber,
                "baud_rate": baud,
                "is_login_switch":login
    }
    Grid{
        anchors.fill: parent
        columns: 2
        rows: 4
        columnSpacing: 10
        PropertyEditLabel{
            width: 100
            text: "板卡"
            horizontalAlignment: Text.AlignRight
        }

        PropertyEditTextField{
            id: card
        }
        PropertyEditLabel{
            width: 100
            text: "板卡号"
            horizontalAlignment: Text.AlignRight
        }
        PropertyEditTextField{
            id: cardNumber
        }
        PropertyEditLabel{
            width: 100
            text: "板卡波特率"
            horizontalAlignment: Text.AlignRight
        }
        PropertyEditTextField{
            id: baud
        }
        PropertyEditLabel{
            width: 100
            text: "登录交换机"
            horizontalAlignment: Text.AlignRight
        }
        PropertyEditCombobox{
            id: login
            model: [0,1,2]
        }
    }
}
