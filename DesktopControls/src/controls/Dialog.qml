import QtQuick 2.7
import QtQuick.Controls 2.0

import DesktopControls 0.1

/*!
    \qmltype Dialog
    \inqmlmodule DesktopControls
    \brief Base dialog.

    默认model模式，overlay居中
*/
Popup {
    id: dialog
    implicitWidth: 300 * Units.dp + margins*2
    implicitHeight: 400 * Units.dp

    leftMargin: (ApplicationWindow.overlay.width-dialog.width)/2
    topMargin: (ApplicationWindow.overlay.height-dialog.height)/2

    modal: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
}
