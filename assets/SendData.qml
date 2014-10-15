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
            Container {
                topPadding: 20
                horizontalAlignment: HorizontalAlignment.Fill
                CustomButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    text: "Send a text"
                    onClicked: {
                        var msgSheet = messageSheet.createObject()
                        msgSheet.index = index
                        msgSheet.open()
                    }
                }
            }
            Container {
                topPadding: 30
                horizontalAlignment: HorizontalAlignment.Fill
                CustomButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    text: "Send text from clipboard"
                    onClicked: {
                        var msgSheet = messageSheet.createObject()
                        msgSheet.index = index
                        msgSheet.text = _control.copyFromClipboard()
                        msgSheet.open()
                    }
                }
            }
            Container {
                topPadding: 30
                horizontalAlignment: HorizontalAlignment.Fill
                CustomButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    text: "Send some files"
                    onClicked: {
                        filePicker.open()
                    }
                }
            }
            Container {
                topPadding: 30
                horizontalAlignment: HorizontalAlignment.Fill
                CustomButton {
                    horizontalAlignment: HorizontalAlignment.Fill
                    text: "Send a folder"
                    onClicked: {
                        folderPicker.open()
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
