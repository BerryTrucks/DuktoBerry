import bb.cascades 1.2
import bb.cascades.pickers 1.0
import bb.system 1.2

Page {
    id: page
    property alias userName: buddy.userName
    property alias system: buddy.system
    property alias avatarUrl: buddy.avatarUrl
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
    ScrollView {
        Container {
            leftPadding: 20
            topPadding: 20
            bottomPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

            CustomItemBuddy {
                id: buddy
                userName: "Laai-Berry"
                system: "BlackBerry"

            }
            Container {
                id: optionsContainer
                property bool sharedPermission: _control.sharedPermission()
                rightPadding: 20
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
                        text: qsTr("Send a text")
                        onClicked: {
                            var msgSheet = messageSheet.createObject()
                            msgSheet.index = page.index
                            msgSheet.user = page.userName
                            msgSheet.open()
                        }
                    }
                }
                Container {
                    topPadding: 30
                    horizontalAlignment: HorizontalAlignment.Fill
                    CustomButton {
                        horizontalAlignment: HorizontalAlignment.Fill
                        text: qsTr("Send text from clipboard")
                        onClicked: {
                            var msgSheet = messageSheet.createObject()
                            msgSheet.index = page.index
                            msgSheet.user = page.userName
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
                        text: qsTr("Send some files")
                        onClicked: {
                            if (optionsContainer.sharedPermission)
                                filePicker.open();
                            else
                                notifyPermissionError.show()
                        }
                    }
                }
                Container {
                    topPadding: 30
                    horizontalAlignment: HorizontalAlignment.Fill
                    CustomButton {
                        horizontalAlignment: HorizontalAlignment.Fill
                        text: qsTr("Send a folder")
                        onClicked: {
                            if (optionsContainer.sharedPermission)
                                folderPicker.open();
                            else
                                notifyPermissionError.show()
                        }
                    }
                }
            }
        }
        attachedObjects: [
            FilePicker {
                id: filePicker
                mode: FilePickerMode.PickerMultiple
                title: qsTr("Select File")
                onFileSelected: {
                    _control.sendSomeFiles(index, selectedFiles)
                    console.log("FileSelected signal received : " + selectedFiles);
                }
            },
            FilePicker {
                id: folderPicker
                mode: FilePickerMode.SaverMultiple
                title: qsTr("Select Folder")
                onFileSelected: {
                    _control.sendSomeFiles(index, selectedFiles)
                    console.log("FileSelected signal received : " + selectedFiles);
                }
            },
            ComponentDefinition {
                id: messageSheet
                MessagePage {
                }
            },
            SystemToast {
                id: notifyPermissionError
                body: qsTr("We don't have permission to use file Picker. Change permissions and restart the app")
            }
        ]
    }
}
