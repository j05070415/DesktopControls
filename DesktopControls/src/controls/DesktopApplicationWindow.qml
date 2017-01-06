import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

import DesktopControls 0.1 as Desktop

/**
  @par
  @code add Toolbar to Main window
    ToolBar{
        id: toolbar
        anchors{
            left: parent.left
            right: parent.right
        }
        height: 80

        RowLayout{
            anchors.fill: parent
            DesktopToolbarGroup{
                width: 200
                height: parent.height
                text: "工程"
                textColor: "white"
                actions:[
                    {
                        text: "新建",
                        tip: "新建工程",
                        textColor: "red",
                        iconName: "remove",
                        iconSize: dp(28),
                        objectName: "new_project",
                        hoverAnimation: false
                    }
                ]
            }

            Item{Layout.fillWidth: true}
        }

        Behavior on height {
            NumberAnimation { duration: MaterialAnimation.pageTransitionDuration }
        }
    }
*/
ApplicationWindow {
    id: root
    flags: Qt.Window
           | Qt.FramelessWindowHint
           | Qt.CustomizeWindowHint
           | Qt.WindowTitleHint
           | Qt.WindowSystemMenuHint
           | Qt.WindowMinimizeButtonHint
           | Qt.WindowMaximizeButtonHint
           | Qt.WindowCloseButtonHint
    Component.onCompleted:{
        visibility = Window.Maximized
        Desktop.Theme.primaryColor = Qt.binding(function(){
            return Desktop.Palette.colors["blue"]["500"]
        })
    }

    property alias title: title.text
    property alias optionButtonVisible: showToolBar.visible
    property color headerColor: Desktop.Theme.primaryColor
    property color toolBarColor: Desktop.Theme.primaryColor

    signal action(string id)

    default property alias center: content.children
    MouseArea{
        anchors.fill: parent
        property point clickPos
        propagateComposedEvents: true
        onPressed: {
            if (root.visibility === Window.Maximized){
                mouse.accepted = false
                return
            }
            clickPos = Qt.point(mouse.x, mouse.y)
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            root.x = root.x + delta.x
            root.y = root.y + delta.y

            mouse.accepted = false
        }
    }

    Column{
        anchors.fill: parent
        //标题栏
        Rectangle {
            id: head
            anchors{
                left: parent.left
                right: parent.right
                margins: 0
            }

            height: dp(26)
            color: headerColor
            RowLayout{
                anchors.fill: parent
                spacing: 3
                Desktop.Label {
                    id: title
                    Layout.fillHeight: true

                    style: "title"
                    text: "未命名"
                    color: Desktop.Theme.lightDark(headerColor,
                                                   Desktop.Theme.light.textColor,
                                                   Desktop.Theme.dark.textColor)
                    verticalAlignment: Text.AlignVCenter
                }

                Item{Layout.fillWidth: true}

                DesktopButton {
                    id: menu
                    backgroundColor: headerColor
                    implicitWidth: head.height
                    implicitHeight: head.height
                    leftPadding: 0
                    rightPadding: 0

                    contentItem: Icon {
                        size: 17
                        awesome: "bars"
                        backgroundColor: showToolBar.backgroundColor
                    }

                    ToolTip.delay: 1000
                    ToolTip.timeout: 500
                    ToolTip.visible: menu.hovered
                    ToolTip.text: "菜单"

                    onClicked: root.action("setting")
                }

                DesktopButton {
                    id: showToolBar
                    backgroundColor: headerColor
                    implicitWidth: head.height
                    implicitHeight: head.height
                    leftPadding: 0
                    rightPadding: 0

                    contentItem: Icon {
                        name: "arrow_drop_down"
                        backgroundColor: showToolBar.backgroundColor
                    }

                    ToolTip.delay: 1000
                    ToolTip.timeout: 500
                    ToolTip.visible: showToolBar.hovered
                    ToolTip.text: "打开/关闭功能区"

                    onClicked: root.action("tool")
                }

                DesktopButton {
                    id: minButton
                    backgroundColor: headerColor
                    implicitWidth: head.height
                    implicitHeight: head.height
                    leftPadding: 0
                    rightPadding: 0

                    contentItem: Icon {
                        backgroundColor: showToolBar.backgroundColor
                        name: "remove"

                        ToolTip.delay: 1000
                        ToolTip.timeout: 500
                        ToolTip.visible: minButton.hovered
                        ToolTip.text: "最小化"
                    }

                    onClicked: {
                        root.visibility = Window.Minimized
                        root.action("min")
                    }
                }

                DesktopButton {
                    id: normalButton
                    backgroundColor: headerColor
                    implicitWidth: head.height
                    implicitHeight: head.height
                    leftPadding: 0
                    rightPadding: 0

                    contentItem: Icon {
                        size: 17
                        backgroundColor: showToolBar.backgroundColor
                        awesome: "clone"

                        ToolTip.delay: 1000
                        ToolTip.timeout: 500
                        ToolTip.visible: normalButton.hovered
                        ToolTip.text: "还原/最大化"
                    }

                    onClicked: {
                        if (root.visibility === Window.Maximized){
                            contentItem.awesome = "square_o"
                            root.visibility = Window.Windowed
                            root.action("restore")
                            root.x = Screen.width/2 - 400
                            root.y = Screen.height/2 - 300
                            root.width = 800
                            root.height = 600
                        } else {
                            contentItem.awesome = "clone"
                            root.visibility = Window.Maximized
                            root.action("max")
                        }
                    }
                }

                DesktopButton {
                    id: closeButton
                    backgroundColor: hovered ? "red" : headerColor
                    implicitWidth: head.height
                    implicitHeight: head.height
                    leftPadding: 0
                    rightPadding: 0

                    contentItem: Icon {
                        backgroundColor: showToolBar.backgroundColor
                        name: "close"

                        ToolTip.delay: 1000
                        ToolTip.timeout: 500
                        ToolTip.visible: closeButton.hovered
                        ToolTip.text: "关闭"
                    }

                    onClicked: {
                        root.close()
                        root.action("close")
                    }
                }
            }
        }

        Item {
            id: content
            anchors{
                left: parent.left
                right: parent.right
            }

            height: parent.height - head.height
        }
    }

    //units
    function dp(dp) {
        return dp * Desktop.Units.dp
    }

    function gu(gu) {
        return units.gu(gu)
    }

    UnitsHelper {
        id: units
    }
}
