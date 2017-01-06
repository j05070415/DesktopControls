
.pragma library

function createLabel(prop, parent) {
    var comp = Qt.createComponent("qrc:/SysComponent/PropertyEditLabel.qml")
    print(comp.status === Component.Ready)
    if (comp.status === Component.Ready) {
        return comp.createObject(parent, {text:prop.name,tip:prop.desc})
    }
}

function createCombobox(id, parent) {
    var comp = Qt.createComponent("qrc:/SysComponent/PropertyEditCombobox.qml")
    if (comp.status === Component.Ready) {
        return comp.createObject(parent, {itemName:id})
    }
}

function createIntSpinbox(id, value, parent) {
    var comp = Qt.createComponent("qrc:/SysComponent/PropertyEditSpinBox.qml")
    if (comp.status === Component.Ready) {
        return comp.createObject(parent, {itemName:id,
                                 text: String(value)})
    }
}

function createFloatSpinbox(id, value, parent) {
    var comp = Qt.createComponent("qrc:/SysComponent/PropertyEditSpinBox.qml")
    if (comp.status === Component.Ready) {
        return comp.createObject(parent, {itemName:id,
                                 text: String(value)})
    }
}

function createLineEdit(id, text, parent) {
    var comp = Qt.createComponent("qrc:/SysComponent/PropertyEditTextField.qml")
    print(comp.status === Component.Ready)
    if (comp.status === Component.Ready) {
        return comp.createObject(parent, {itemName:id,
                                 text: text})
    }
}

function createPathBox(id, text, parent) {
    var comp = Qt.createComponent("qrc:/SysComponent/PropertyEditPathBox.qml")
    if (comp.status === Component.Ready) {
        return comp.createObject(parent, {itemName:id,
                                 pathText: text})
    }
}

function createFileDialog(text, parent) {
    var comp = Qt.createComponent("qrc:/SysComponent/HwaFileDialog.qml")
    if (comp.status === Component.Ready) {
        return comp.createObject(parent, {text: text})
    }
}

function createEnumStrategy(id, text, parent) {
    var com = Qt.createComponent('StrategyComponent.qml')
    var editObj
    if (com.status === Component.Ready) {
        var properties = new Object
        properties['itemName'] = id
        properties['text'] = text
        editObj = com.createObject(parent, properties)
    }
    else
    {
        print(com.errorString())
    }

    return editObj
}

function createDelegateControl(json, parent) {
    var item
    if (json.type === 'label')
    {
        item = createLabel(json.value, parent)
        item.color = "grey"
    }
    else if (json.type === 'text')
    {
        item = createLineEdit(json.id, json.value, parent)
        item.maximumLength = Number(json.scope)
        item.previous = json.value
    }
    else if (json.type === 'enum')
    {
        item = createCombobox(json.id, parent)
        item.model = json.scope.split(";")
        item.selectedIndex = json.value
    }
    else if (json.type === 'int')
    {
        item = createIntSpinbox(json.id, json.value, parent)
        item.previous = json.value
        var scop = json.scope.split(",")
        if (scop.length === 2)
        {
            item.valueType = 0
            item.minimumValue = scop[0]
            item.maximumValue = scop[1]
        }
    }
    else if (json.type === 'double' || json.type == 'float')
    {
        item = createFloatSpinbox(json.id, json.value, parent)
        item.previous = json.value
        var scop = json.scope.split(",")
        if (scop.length === 2)
        {
            item.valueType = 1
            item.minimumValue = scop[0]
            item.maximumValue = scop[1]
        }
    }
    else if (json.type === 'enum_strategy')
    {
        item = createEnumStrategy(json.id, json.value, parent)
    }
    else if (json.type === 'path')
    {
        item = createPathBox(json.id, json.value, parent)
        if (item && json.value)
            item.pathText = json.value
            item.fileFilters = ["Config File (*.xml)"]
    }

    item.enabled = Number(json.enabled) === 0 ? false : true
    return item
}

function createItem(prop, column, parent) {
    print("createItem"+column)
    if (column === 0) {
        return createLabel(prop, parent)
    }
    else if (column === 1) {
        return createDelegateControl(prop, parent)
    }
}
