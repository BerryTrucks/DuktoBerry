import bb.cascades 1.2

Sheet {
    id: msgSheet
    property variant index
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
        Container {
            leftPadding: 20
            rightPadding: 20
            Label {
                text: "to Laairoy"
            }
            Container {
                CustomTextArea {
                    id: textToSend
                    preferredHeight: 400
                }
                Container {
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                CustomButton {
                    horizontalAlignment: HorizontalAlignment.Center
                    preferredWidth: 400
                    text: "send"
                    background: Color.Green
                    onClicked: {
                        _control.sendtext(index, textToSend.text);
                        msgSheet.close()
                    }
                    }
                }
            }
            
        }
    }
}