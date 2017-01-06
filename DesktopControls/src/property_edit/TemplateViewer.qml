import QtQuick 2.7

/*!
  \\qmltype TemplateViewer
  \\brief 根据模板创建视图, 视图中控件值改变时传递itemChanged信号；
        更新控件内容通过 updateContent.
*/
Rectangle {
    id: viewer
    implicitWidth: 400
    implicitHeight: 300
    color: "white"

    function clear(){
        if (object) object.destroy()
    }

    signal itemChanged(string id, var value)

    //当前创建模板对象
    property var component
    property var object

    function create(template){
        if (!template) {
            print("TemplateViewer create failed,template is null;check is configed template")
            return
        }

        if (object) clear()

        component = Qt.createComponent(template, viewer)
        if (component.status === Component.Ready){
            object = component.createObject(viewer, {x:0, y:0,
                                       width:viewer.width,
                                       height:viewer.height})
            if (object.itemChanged)
                object.itemChanged.connect(viewer.itemChanged)
        }
        else
            print(component.errorString())
    }

    function updateContent(content){
        if (object && object.updateContent)
            object.updateContent(content)
        else
            print("object is null or no function updateContent, object:"+object)
    }
}
