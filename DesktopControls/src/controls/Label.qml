/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.0
import DesktopControls 0.1

/*!
   \qmltype Label
   \inqmlmodule Material

   \brief A text label with many different font styles from Material Design.
 */
Text {
    id: label
    property string style: "body3"

    property color backgroundColor: "white"
    property var fontInfo: Theme.fontStyles[style]

    verticalAlignment: Text.AlignVCenter
    font.pixelSize: fontInfo.size * Units.dp
    font.family: Theme.fontName
    font.weight: {
        var weight = fontInfo.font

        if (weight === "medium") {
            return Font.DemiBold
        } else if (weight === "regular") {
            return Font.Normal
        } else if (weight === "light") {
            return Font.Light
        }
    }

    font.capitalization: style == "button" ? Font.AllUppercase : Font.MixedCase

    color: Theme.lightDark(backgroundColor,
                                   Theme.light.textColor,
                                   Theme.dark.textColor)
}
