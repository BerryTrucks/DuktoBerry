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
                TextArea {
                    id: textToSend
                    preferredHeight: 300
                }
                Button {
                    horizontalAlignment: HorizontalAlignment.Center
                    text: "send"
                    onClicked: {
                        _control.sendtext(index, textToSend.text);
                    }
                }
            }
            
        }
    }
}