import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2

import DesktopControls 0.1 as Desktop

Item {
    id: root
    implicitWidth: 100
    implicitHeight: 50

    property alias title: fileDlg.title
    property alias selectFile: fileDlg.selectFolder
    property alias fileFilters: fileDlg.nameFilters
    property alias selectMultiple: fileDlg.selectMultiple

    signal itemChanged(string id, var value)

    function setValue(value){
        path.text = value
    }

    Row {
        id: lay
        anchors.fill: parent
        spacing: 3

        TextField {
            id: path
            anchors{
                top: parent.top
                bottom: parent.bottom
            }
            width: parent.width - pathButton.width - 10

            onAccepted: {
                itemChanged(root.objectName, text)
                focus = false
            }
        }

        Desktop.Button {
            id: pathButton
            text: "..."
            width: 40 * Desktop.Units.dp
            height: 40 * Desktop.Units.dp
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                var lastFile = fileDlg.lastFolder.toString();;
                if (lastFile.indexOf("file:///") < 0)
                    lastFile = "file:///" + lastFile;

                fileDlg.folder = lastFile;
                fileDlg.open();
            }
        }
    }

    FileDialog {
        id: fileDlg
        width: 400
        height: 300
        title: "选择文件"
        visible: false
        selectMultiple: true
        property url lastFolder
    }

    Connections {
        target: fileDlg

        onAccepted: {
            var fileInfo = "";

            for (var i = 0; i < fileDlg.fileUrls.length; i++)
            {
                var tempFile = fileDlg.fileUrls[i].toString();
                fileInfo += tempFile.replace("file:///", "");

                if (i !== fileDlg.fileUrls.length-1)
                {
                    fileInfo += ",";
                }
            }

            path.text = fileInfo
            fileDlg.lastFolder = fileInfo;
            root.itemChanged(root.objectName, fileInfo);
        }
    }
}
