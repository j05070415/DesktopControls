import QtQuick 2.7
import QtQuick.Controls 2.0
import DesktopControls 0.1

Pane {
    id: root

    Flickable{
        anchors.fill: parent
        clip: true

        contentHeight: layer.implicitHeight
        ScrollBar.vertical: ScrollBar {}

        Flow{
            anchors.fill: parent
            spacing: 50
            id: layer
            Repeater{
                model: Object.keys(Palette.colors)
                delegate: Column{
                    spacing: 3
                    property var currentColor: modelData
                    Label{
                        style: "headline"
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: currentColor
                    }

                    Repeater{
                        model: Object.keys(Palette.colors[currentColor])
                        delegate: Rectangle{
                            width: 250
                            height: 30
                            color: Palette.colors[currentColor][modelData]
                            Label{
                                anchors.centerIn: parent
                                text: modelData+":"+Palette.colors[currentColor][modelData]
                                color: Theme.lightDark(Palette.colors[currentColor][modelData],
                                                               Theme.light.iconColor,
                                                               Theme.dark.iconColor)
                            }
                        }
                    }
                }
            }
        }
    }
}
