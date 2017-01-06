/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Creator.
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
****************************************************************************/

import QtQuick 2.1
import QtQuick.Controls 2.0
import QtQuick.Controls 1.1 as Controls
import QtQuick.Layouts 1.0
import DesktopControls 0.1

Item {
    id: section
    property alias caption: label.text
    property color headerColor: "lightgrey"
    property int leftPadding: 8
    property int topPadding: 4
    property int rightPadding: 0

    readonly property int animationDuration: 120

    clip: true

    ItemDelegate {
        id: header
        height: 18

        anchors.left: parent.left
        anchors.right: parent.right
        hoverEnabled: true

        background: Rectangle{
            anchors.fill: parent
            color: header.hovered ?
                       header.pressed ? Qt.darker(section.headerColor,1.2):
                                        Qt.lighter(section.headerColor,0.8) :
            section.headerColor
        }

            contentItem: RowLayout{
                anchors.fill: parent
                Icon {
                    id: arrow
                    backgroundColor: header.background.color
                    size: 20
                    awesome: "angle_down"
                    anchors.verticalCenter: parent.verticalCenter
                    Behavior on rotation {
                        NumberAnimation {
                            easing.type: Easing.OutCubic
                            duration: animationDuration
                        }
                    }
                }
                Label {
                    id: label
                    Layout.fillWidth: true
                    anchors.verticalCenter: parent.verticalCenter
                    color: Theme.lightDark(header.background.color, "black", "white")
                }
            }

            onClicked: {
                if (section.state === "")
                    section.state = "Collapsed"
                else
                    section.state = ""
            }
        }

        default property alias __content: row.children

        readonly property alias contentItem: row

        height: Math.round(row.height + header.height + 8)

        Column {
            anchors.left: parent.left
            anchors.leftMargin: leftPadding
            anchors.right: parent.right
            anchors.rightMargin: rightPadding
            anchors.top: header.bottom
            anchors.topMargin: topPadding
            id: row
        }

        Behavior on height {
            NumberAnimation {
                easing.type: Easing.OutCubic
                duration: animationDuration
            }
        }

        states: [
            State {
                name: "Collapsed"
                PropertyChanges {
                    target: section
                    height: header.height
                }
                PropertyChanges {
                    target: arrow
                    rotation: -90
                }
            }
        ]
    }
