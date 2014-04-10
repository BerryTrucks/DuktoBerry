import bb.cascades 1.2
import bb.cascades.pickers 1.0

Page {
    property variant index
    titleBar: TitleBar {
        kind: TitleBarKind.FreeForm
        kindProperties: FreeFormTitleBarKindProperties {
            Container {
                leftPadding: 15
                rightPadding: 15
                preferredHeight: 110
                background: Color.create("#30910e")
                horizontalAlignment: HorizontalAlignment.Fill
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Fill
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 8
                    }
                    Label {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        text: qsTr("Send Data")
                        textStyle {
                            base: SystemDefaults.TextStyles.TitleText
                            fontSize: FontSize.PointValue
                            fontSizeValue: 16
                            color: Color.White
                        }

                    }
                }
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
        }
    ]
}
