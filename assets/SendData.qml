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
                        text: "Send Data"
                        textStyle {
                            base: SystemDefaults.TextStyles.TitleText
                            fontSize: FontSize.PointValue
                            fontSizeValue: 16
                        }

                    }
                }
            }
        }
    }

    Container {
        leftPadding: 20
        topPadding: 20
        Container {

            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                ImageView {
                    maxWidth: 150
                    maxHeight: 150
                    imageSource: "asset:///images/tux.jpg"
                }
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 23
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                Label {
                    text: "Laairoy (You)"
                    textStyle.fontSize: FontSize.Large
                }
                Label {
                    text: "at DesktopS"
                    textStyle.fontSize: FontSize.Medium
                }
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 77
                }
            }
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
            directories: [ "/accounts/1000/shared/" ]
            onFileSelected: {
                _control.sendSomeFiles(index, selectedFiles)
                console.log("FileSelected signal received : " + selectedFiles);
            }
        }
    ]
}
