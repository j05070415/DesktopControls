import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

import DesktopControls 0.1 as Desktop

/*!
    \qmltype MessageDialog
    \inqmlmodule DesktopControls
    \brief 消息提示对话框

    默认两个按钮，确认和取消；应用按钮默认隐藏，用户使用时手动开启
*/
Dialog {
    id: box
    property int contentMargins: 24 * Desktop.Units.dp

    property alias title: header.text
    signal accepted
    signal cancel
    signal apply

    property alias okButton: ok
    property alias cancelButton: reject
    property alias applyButton: appl

    default property alias dialogContent: column.children

    onAccepted: box.close()
    onCancel: box.close()

    Flickable{
        id: flick
        anchors.fill: parent
        ColumnLayout{
            anchors.fill: parent
            Desktop.Label{
                id: header
                Layout.fillWidth: true
                style: "caption"
                text: "标题"
            }

            Flickable {
                id: content

                clip: true
                Layout.fillHeight: true
                Layout.fillWidth: true

                Keys.onUpPressed: ver.decrease()
                Keys.onDownPressed: ver.increase()
                Keys.onLeftPressed: hor.decrease()
                Keys.onRightPressed: hor.increase()

                contentHeight: column.height
                contentWidth: column.width
                ScrollBar.vertical: ScrollBar { id: ver }
                ScrollBar.horizontal: ScrollBar { id: hor }

                Column {
                    id: column
                    spacing: 8 * Desktop.Units.dp
                }
            }

            RowLayout{
                id: bottom
                Item{Layout.fillWidth: true}
                Desktop.Button{
                    id: reject
                    text: "取消"

                    Keys.onReturnPressed: cancel()
                    Keys.onEnterPressed: cancel()
                    onClicked: {cancel();box.close()}
                }
                Desktop.Button{
                    id: ok
                    text: "确认"

                    focus: true
                    Keys.forwardTo: [ok,content]
                    Keys.onReturnPressed: accepted()
                    Keys.onEnterPressed: accepted()
                    onClicked: {accepted();box.close()}
                }
                Desktop.Button{
                    id: appl
                    highlighted: true
                    text: "应用"

                    Keys.onReturnPressed: apply()
                    Keys.onEnterPressed: apply()
                    onClicked: {apply()}
                }
            }
        }
    }
}
