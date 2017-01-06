/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

#include "plugin.h"

#include <QtQml>
#include <QDebug>

#include "core/device.h"
#include "core/units.h"
#include "model/TreeModel.h"

class MaterialRegisterHelper {

public:
    MaterialRegisterHelper(const char *uri) {
        qmlRegisterSingletonType<Device>(uri, 0, 1, "Device", Device::qmlSingleton);
        qmlRegisterUncreatableType<Units>(uri, 0, 1, "Units", QStringLiteral("Units can only be used via the attached property."));
    }
};

void DesktopControlsPlugin::registerTypes(const char *uri)
{
    // @uri DesktopControls
    Q_ASSERT(uri == QStringLiteral("DesktopControls"));

    //tree model
    qmlRegisterType<HwaTreeModel>(uri, 0, 1, "StandardTreeModel");

    //core
    qmlRegisterType(QUrl("qrc:/Desktop/AwesomeIcon.qml"), uri, 0, 1, "AwesomeIcon");
    qmlRegisterType(QUrl("qrc:/Desktop/Icon.qml"), uri, 0, 1, "Icon");
    qmlRegisterType(QUrl("qrc:/Desktop/Object.qml"), uri, 0, 1, "Object");
    qmlRegisterType(QUrl("qrc:/Desktop/UnitsHelper.qml"), uri, 0, 1, "UnitsHelper");
    qmlRegisterType(QUrl("qrc:/Desktop/ThemePalette.qml"), uri, 0, 1, "ThemePalette");
    qmlRegisterSingletonType(QUrl("qrc:/Desktop/MaterialAnimation.qml"), uri, 0, 1, "MaterialAnimation");
    qmlRegisterSingletonType(QUrl("qrc:/Desktop/Palette.qml"), uri, 0, 1, "Palette");
    qmlRegisterSingletonType(QUrl("qrc:/Desktop/Theme.qml"), uri, 0, 1, "Theme");

    //components
    qmlRegisterType(QUrl("qrc:/Desktop/DesktopThinDivider.qml"), uri, 0, 1, "DesktopThinDivider");
    qmlRegisterType(QUrl("qrc:/Desktop/CircleMask.qml"), uri, 0, 1, "CircleMask");
    qmlRegisterType(QUrl("qrc:/Desktop/DesktopTableViewStyle.qml"), uri, 0, 1, "DesktopTableViewStyle");
    qmlRegisterType(QUrl("qrc:/Desktop/DesktopTreeViewStyle.qml"), uri, 0, 1, "DesktopTreeViewStyle");
    qmlRegisterType(QUrl("qrc:/Desktop/ExpandingSpacer.qml"), uri, 0, 1, "ExpandingSpacer");
    qmlRegisterType(QUrl("qrc:/Desktop/Section.qml"), uri, 0, 1, "Section");
    qmlRegisterType(QUrl("qrc:/Desktop/SectionLayout.qml"), uri, 0, 1, "SectionLayout");

    //controls
    qmlRegisterType(QUrl("qrc:/Desktop/DesktopApplicationWindow.qml"), uri, 0, 1, "DesktopApplicationWindow");
    qmlRegisterType(QUrl("qrc:/Desktop/DesktopToolbarGroup.qml"), uri, 0, 1, "DesktopToolbarGroup");
    qmlRegisterType(QUrl("qrc:/Desktop/DesktopToolbarIconButton.qml"), uri, 0, 1, "DesktopToolbarIconButton");
    qmlRegisterType(QUrl("qrc:/Desktop/DesktopButton.qml"), uri, 0, 1, "DesktopButton");
    qmlRegisterType(QUrl("qrc:/Desktop/Dialog.qml"), uri, 0, 1, "Dialog");
    qmlRegisterType(QUrl("qrc:/Desktop/Label.qml"), uri, 0, 1, "Label");
    qmlRegisterType(QUrl("qrc:/Desktop/Button.qml"), uri, 0, 1, "Button");
    qmlRegisterType(QUrl("qrc:/Desktop/MessageDialog.qml"), uri, 0, 1, "MessageDialog");
    qmlRegisterType(QUrl("qrc:/Desktop/CircleImage.qml"), uri, 0, 1, "CircleImage");
    qmlRegisterType(QUrl("qrc:/Desktop/Snackbar.qml"), uri, 0, 1, "Snackbar");
    qmlRegisterType(QUrl("qrc:/Desktop/IndicationButton.qml"), uri, 0, 1, "IndicationButton");

    //property edit
    qmlRegisterType(QUrl("qrc:/Desktop/PropertyEditor.qml"), uri, 0, 1, "PropertyEditor");
    qmlRegisterType(QUrl("qrc:/Desktop/TemplateViewer.qml"), uri, 0, 1, "TemplateViewer");
    qmlRegisterType(QUrl("qrc:/Desktop/PropertyEditCombobox.qml"), uri, 0, 1, "PropertyEditCombobox");
    qmlRegisterType(QUrl("qrc:/Desktop/PropertyEditDoubleSpinBox.qml"), uri, 0, 1, "PropertyEditDoubleSpinBox");
    qmlRegisterType(QUrl("qrc:/Desktop/PropertyEditIntSpinBox.qml"), uri, 0, 1, "PropertyEditIntSpinBox");
    qmlRegisterType(QUrl("qrc:/Desktop/PropertyEditLabel.qml"), uri, 0, 1, "PropertyEditLabel");
    qmlRegisterType(QUrl("qrc:/Desktop/PropertyEditPathBox.qml"), uri, 0, 1, "PropertyEditPathBox");
    qmlRegisterType(QUrl("qrc:/Desktop/PropertyEditTextField.qml"), uri, 0, 1, "PropertyEditTextField");

    MaterialRegisterHelper helper(uri);
}

// When using QPM, the C++ plugin is not used and the QML types must be registered manually
#ifdef QPM_INIT
    static MaterialRegisterHelper registerHelper("DesktopControls");
#endif
