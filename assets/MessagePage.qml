import bb.cascades 1.2

Sheet {
    id: msgSheet
    property variant index
    property alias text: textToSend.text
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("Send Text")
                closeButtonActive: true
                onBackButtonClicked: {
                    msgSheet.close()
                }
            }
        }
        ScrollView {
            Container {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                Label {
                    text: "to Laairoy"
                }
                Container {
                    topPadding: 20
                    CustomTextArea {
                        id: textToSend
                        preferredHeight: 400
                    }
                    Container {
                        topPadding: 20
                        horizontalAlignment: HorizontalAlignment.Center
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        CustomButton {
                            horizontalAlignment: HorizontalAlignment.Center
                            preferredWidth: 350
                            text: "Send"
                            background: Color.Green
                            actived: true
                            onClicked: {
                                _control.sendtext(index, textToSend.text);
                                msgSheet.close()
                            }
                        }
                        Container {
                            horizontalAlignment: HorizontalAlignment.Right
                            leftPadding: 40
                            CustomButton {
                                horizontalAlignment: HorizontalAlignment.Center
                                preferredWidth: 350
                                text: "Paste from clipboard"
                                background: Color.Green
                                onClicked: {
                                    textToSend.text = textToSend.text + _control.copyFromClipboard()
                                }
                            }
                        }
                    }
                }

            }
        }
    }
}