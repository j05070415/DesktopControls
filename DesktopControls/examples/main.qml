import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.0
import DesktopControls 0.1

DesktopApplicationWindow {
    id: window
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    property int toolBarHeight: 60
    property int buttonSize: 50

    Material.primary: Theme.primaryColor
    Material.accent: Theme.accentColor

    Rectangle{
        id: tool
        height: toolBarHeight
        color: Material.primary
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }

        RowLayout{
            anchors.fill: parent
            DesktopToolbarGroup{
                height: parent.height
                actions:[
                    {
                        width: buttonSize,
                        height: buttonSize,
                        text: "新建",
                        tip: "新建工程",
                        textColor: "red",
                        iconSource: "icon://awesome/remove",
                        iconSize: dp(28),
                        objectName: "new_project",
                        hoverAnimation: false
                    }
                ]
            }
            DesktopThinDivider{
                id: d1
                width: 1
                height: parent.height
                color: Theme.primaryColor
                gradient: Gradient {
                    GradientStop { position: 0.0; color: d1.color }
                    GradientStop { position: 0.5; color: "white" }
                    GradientStop { position: 1.0; color: d1.color }
                }
            }

            DesktopToolbarGroup{
                height: parent.height
                actions:[
                    {
                        width: buttonSize,
                        height: buttonSize,
                        text: "新建",
                        tip: "新建工程",
                        textColor: "white",
                        iconSource: "icon://awesome/remove",
                        iconSize: dp(28),
                        objectName: "new_project",
                        hoverAnimation: false
                    },
                    {
                        width: buttonSize,
                        height: buttonSize,
                        text: "打开",
                        tip: "打开工程",
                        iconSource: "icon://awesome/close",
                        iconSize: dp(28),
                        textColor: "white",
                        objectName: "open_project",
                        hoverAnimation: false
                    },
                    {
                        width: buttonSize,
                        height: buttonSize,
                        text: "打开",
                        tip: "打开工程",
                        iconSource: "icon://awesome/close",
                        iconSize: dp(28),
                        textColor: "white",
                        objectName: "open_project1",
                        hoverAnimation: false
                    }
                ]
            }
            DesktopThinDivider{
                id: d2
                width: 1
                height: parent.height
                color: Theme.primaryColor
                gradient: Gradient {
                    GradientStop { position: 0.0; color: d1.color }
                    GradientStop { position: 0.5; color: "white" }
                    GradientStop { position: 1.0; color: d1.color }
                }
            }

            DesktopToolbarGroup{
                height: parent.height
                actions:[
                    {
                        width: buttonSize,
                        height: buttonSize,
                        text: "新建",
                        tip: "新建工程",
                        textColor: "white",
                        iconSource: "icon://awesome/remove",
                        iconSize: dp(28),
                        objectName: "new_project",
                        hoverAnimation: false
                    },
                    {
                        width: buttonSize,
                        height: buttonSize,
                        text: "打开",
                        tip: "打开工程",
                        iconSource: "icon://awesome/close",
                        iconSize: dp(28),
                        textColor: "white",
                        objectName: "open_project",
                        hoverAnimation: false
                    },
                    {
                        width: buttonSize,
                        height: buttonSize,
                        text: "打开",
                        tip: "打开工程",
                        iconSource: "icon://awesome/close",
                        iconSize: dp(28),
                        textColor: "white",
                        objectName: "open_project1",
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

    SwipeView{
        anchors{
            top: tool.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        currentIndex: 3

        PropeditDemo{

        }

        DialogDemo{

        }

        PalettePage{

        }

        DefaultIcons{

        }
    }

    Snackbar{
        id: snack
    }

    onAction:{
        if (id === "close"){
            window.close()
        } else if (id === "min") {
            window.showMinimized()
        } else if (id === "tool") {
            if (tool.height > 0)
                tool.height = 0
            else
                tool.height = toolBarHeight
        }
    }
}
