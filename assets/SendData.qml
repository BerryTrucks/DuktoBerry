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
            leftPadding: 20
            rightPadding: 40
            topPadding: 80
            horizontalAlignment: HorizontalAlignment.Fill
            Label {
                text: qsTr("What do you want to do?")
                textStyle.fontSize: FontSize.Large
            }
            CustomButton {
                horizontalAlignment: HorizontalAlignment.Center
                preferredWidth: 550
                text: "send file"
                onClicked: {
                    filePicker.open()
                }
            }
            Container {
                topPadding: 20
                horizontalAlignment: HorizontalAlignment.Center
                CustomButton {
                    preferredWidth: 550
                    text: "send a folder"
                    onClicked: {
                        folderPicker.open()
                    }
                }
            }
            Container {
                topPadding: 20
                horizontalAlignment: HorizontalAlignment.Center
                CustomButton {
                    preferredWidth: 550
                    text: "send a text"
                    onClicked: {
                        var msgSheet = messageSheet.createObject()
                        msgSheet.index = index
                        msgSheet.open()
                    }
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

        },
        ComponentDefinition {
            id: messageSheet
            MessagePage {
            }
        }
    ]
}
