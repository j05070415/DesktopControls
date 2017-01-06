import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import DesktopControls 0.1

TreeViewStyle{
    id: root
    property int scrollWidth: 10
    property int rowHeight: 25
    property int headerHeight: 20
    headerDelegate: Rectangle{
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        implicitHeight: headerHeight
        ColumnLayout{
            anchors.fill: parent
            spacing: 0
            RowLayout{
                Layout.leftMargin: 3
                Layout.fillHeight: true
                Label{
                    Layout.fillWidth: true
                    anchors.verticalCenter: parent.verticalCenter
                    text: styleData.value
                }
                Rectangle{
                    Layout.fillHeight: true

                    width: 1
                    color: "black"
                    opacity: 0.1
                }
            }
            Rectangle{
                Layout.fillWidth: true
                height: 1
                color: "black"
                opacity: 0.1
            }
        }
    }

    handle: Item{
        implicitWidth: !styleData.horizontal ? scrollWidth : 100
        implicitHeight: styleData.horizontal ? scrollWidth : 0
        Rectangle{
            anchors.fill: parent
            width: !styleData.horizontal ? scrollWidth : parent.width
            height: styleData.horizontal ? scrollWidth : parent.height
            radius: styleData.horizontal ? (width/2 - 1) : (height/2 - 1)
            color: "black"
            opacity: 0.3
        }
    }
    scrollBarBackground:Item{
        implicitWidth: !styleData.horizontal ? scrollWidth : 0
        implicitHeight: styleData.horizontal ? scrollWidth : 0
        Rectangle {
            anchors.fill: parent
            width: !styleData.horizontal ? scrollWidth : parent.width
            height: styleData.horizontal ? scrollWidth : parent.height
            radius: !styleData.horizontal ? (width/2 - 1) : (height/2 - 1)
            color: "white"
            opacity: 0.3
        }
    }
    incrementControl: Item{}
    decrementControl: Item{}

    rowDelegate: Rectangle{
        implicitHeight: rowHeight
        implicitWidth: parent.width
        color: styleData.selected ? Theme.primaryColor : "white"
    }

    branchDelegate: Icon{
        backgroundColor: root.backgroundColor
        size: 20
        awesome: "angle_right"
        rotation: styleData.isExpanded ? 90 : 0
        Behavior on rotation {
            NumberAnimation {
                easing.type: Easing.OutCubic
                duration: 120
            }
        }
    }
}
