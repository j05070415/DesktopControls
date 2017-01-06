import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQml.Models 2.2
import QtQuick.Controls 1.4 as Controls
import QtQuick.Controls 2.0 as Controls2

import DesktopControls 0.1

/*!
    \qmltype PropertyEditor
    \inqmlmodule DesktopControls
    \brief 动态创建属性编辑界面
*/
Controls.TableView {
    id: root
    headerVisible: true
    frameVisible: false

    property var currentIndex
    property var columRoles: new Array
    model: ListModel { id: listModel; }

    signal itemChanged(string id, var value)

    Component.onCompleted: {
        columRoles.push("name")
        columRoles.push("value")
    }

    function clear() {
        listModel.clear()
        root.currentIndex = null
    }

    function updateProperties(json) {
        if (json.length === 0) return

        print("count:"+listModel.count)
        listModel.clear()
        print("clear")

        var dict = new Object
        for (var i=0; i<json.length; ++i) {
            var currentProp = json[i]

            dict["name"] = currentProp
            dict["value"] = currentProp
            listModel.append(dict)
        }
    }

    function resetEditor(selectedIndex, json) {
        if (selectedIndex === currentIndex) return

        currentIndex = selectedIndex

        updateProperties(json)
    }

    Controls.TableViewColumn {
        title: "名称"
        role: "name"
        width: root.width/3
    }

    Controls.TableViewColumn {
        title: "值"
        role: "value"
        width: root.width/3*2
    }

    itemDelegate: Controls2.ItemDelegate {
        id: container
        checked: false
        padding: 0

        Connections {
            target: styleData
            onValueChanged: {
                if (styleData.value.length !== 0) {
                    var myEditor = createItem(styleData.value,
                                              styleData.column,
                                              container)
                    if (myEditor &&
                            myEditor.itemChanged &&
                            styleData.column === 1)
                        myEditor.itemChanged.connect(root.itemChanged)
                }
            }
        }
    }

    rowDelegate: Controls2.Pane{
        height: 40
        hoverEnabled: true

        onHoveredChanged: {
            if (hovered)
                background.color.a = 0.6
            else
                background.color.a = 1
        }
    }

    headerDelegate: Controls2.Pane{
        id: header
        padding: 0

        height: 30 * Units.dp
        Controls2.Label{
            anchors{
                top: parent.top
                bottom: divider.top
                horizontalCenter: parent.horizontalCenter
            }

            verticalAlignment:Text.AlignVCenter
            horizontalAlignment:Text.AlignHCenter
            text: styleData.value
        }

        DesktopThinDivider{
            id: divider
            anchors{
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }
    }

    function appendColumn(title, role, width)
    {
        var str = 'import QtQuick 2.7;import QtQuick.Controls 1.4; TableViewColumn {title: "'
                + title + '";role:"' + role + '";width:' + width + '}'
        var newObject = Qt.createQmlObject(str, root, "dynamicSnippet1");

        root.addColumn(newObject)
        columRoles.push(role)
    }

    function createComponent(file, mode, props, parent){
        var component =
                Qt.createComponent("qrc:/Desktop/"+file, mode, parent)
        if (component.status === Component.Ready)
            return component.createObject(parent, props)
    }

    function createDelegateControl(json, parent) {
        var item
        var enable = Number(json.enabled) !== 0
        if (json.type === 'label')
        {
            item = createComponent("PropertyEditLabel.qml",
                                   Component.PreferSynchronous,
                                   {text:json.name,
                                       enabled: enable,
                                       color: "grey"},
                                   parent)
        }
        else if (json.type === 'text')
        {
            item = createComponent("PropertyEditTextField.qml",
                                   Component.PreferSynchronous,
                                   {itemName:json.id,
                                       enabled: enable,
                                       text: json.value,
                                       maximumLength: Number(json.scope),
                                       previous:json.value},
                                   parent)
        }
        else if (json.type === 'enum')
        {
            item = createComponent("PropertyEditCombobox.qml",
                                   Component.PreferSynchronous,
                                   {itemName:json.id,
                                       enabled: enable,
                                       model: json.scope.split(";"),
                                       currentIndex:json.value},
                                   parent)
        }
        else if (json.type === 'int')
        {
            var scop = json.scope.split(",")
            if (scop.length === 2)
            {
                item = createComponent("PropertyEditIntSpinBox.qml",
                                       Component.PreferSynchronous,
                                       {itemName:json.id,
                                           enabled: enable,
                                           value: Number(json.value),
                                           from: Number(scop[0]),
                                           to: Number(scop[1])},
                                       parent)
            }
        }
        else if (json.type === 'double' || json.type === 'float')
        {
            scop = json.scope.split(",")
            if (scop.length === 2)
            {
                item = createComponent("PropertyEditDoubleSpinBox.qml",
                                       Component.PreferSynchronous,
                                       {itemName:json.id,
                                           enabled: enable,
                                           value: Number(json.value)*100,
                                           from: Number(scop[0]*100),
                                           to: Number(scop[1]*100)},
                                       parent)
            }
        }
        else if (json.type === 'enum_strategy')
        {
            item = createComponent("PropertyEditIntSpinBox.qml",
                                   Component.PreferSynchronous,
                                   {itemName:json.id,
                                       enabled: enable,
                                       text: String(json.value)},
                                   parent)
        }
        else if (json.type === 'path')
        {
            item = createComponent("PropertyEditPathBox.qml",
                                   Component.PreferSynchronous,
                                   {itemName:json.id,
                                       enabled: enable,
                                       text: String(json.value),
                                       fileFilters: ["Config File (*.xml)"]},
                                   parent)
        }

        return item
    }

    function createItem(prop, column, parent) {
        if (column === 0) {
            return createComponent("PropertyEditLabel.qml",
                                   Component.PreferSynchronous,
                                   {text:prop.name,
                                       tip:prop.desc},
                                   parent)
        }
        else if (column === 1) {
            return createDelegateControl(prop, parent)
        }
    }
}
