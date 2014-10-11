import bb.cascades 1.2
import bb.cascades.pickers 1.0

Page {
    property variant index
    titleBar: TitleBar {
        kind: TitleBarKind.FreeForm
        kindProperties: CustomFreeFormTitleBar {
            title: qsTr("Send Data")
            closeButtonActive: true
            onBackButtonClicked: {
                navPane.pop();
            }
        }
    }

    Container {
        leftPadding: 20
        topPadding: 20
        CustomItemBuddy {
            userName: "Laai-Berry"
            system: "BlackBerry"
        }
        Container {
            topPadding: 80
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text: qsTr("What do you want to do?")
                textStyle.fontSize: FontSize.Large
            }
            Button {
                horizontalAlignment: HorizontalAlignment.Center
                text: "send file"
                onClicked: {
                    filePicker.open()
                }
            }
            Button {
                horizontalAlignment: HorizontalAlignment.Center
                text: "send a folder"
                onClicked: {
                    folderPicker.open()
                }
            }
            Button {
                horizontalAlignment: HorizontalAlignment.Center
                text: "send a text"
                onClicked: {
                    _control.sendtext(index, "olamundo");
                }
            }
        }
    }
    attachedObjects: [
        FilePicker {
            id: filePicker
            mode: FilePickerMode.PickerMultiple
            title: "Select File"
            onFileSelected: {
                _control.sendSomeFiles(index, selectedFiles)
                console.log("FileSelected signal received : " + selectedFiles);
            }
        },
        FilePicker {
            id: folderPicker
            mode: FilePickerMode.SaverMultiple
            title: "Select Folder"
            onFileSelected: {
                _control.sendSomeFiles(index, selectedFiles)
                console.log("FileSelected signal received : " + selectedFiles[0]);
            }
            
        }
    ]
}
