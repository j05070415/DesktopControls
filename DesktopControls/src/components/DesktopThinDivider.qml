import QtQuick 2.7
/*!
DesktopThinDivider {
    id: devider

    gradient: Gradient {
        GradientStop { position: 0.0; color: devider.color }
        GradientStop { position: 0.5; color: "white" }
        GradientStop { position: 1.0; color: devider.color }
    }
}
*/

Rectangle {
    id: devider

    color: Qt.rgba(0,0,0,0.1)
    height: 1
    border.color: color
}
