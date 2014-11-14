import bb.cascades 1.2
import bb.system 1.0

Sheet {
    id: msgSheet
    property variant index
    property string user: "Laairoy"
    property alias text: textToSend.text
    property bool editable: true
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: msgSheet.editable ? qsTr("Send Text") : qsTr("Text")
                closeButtonActive: true
                onBackButtonClicked: {
                    msgSheet.close()
                }
            }
        }
        Container {
            topPadding: 20
            leftPadding: 20
            rightPadding: 20
            Label {
                id: user
                text: (msgSheet.editable ? qsTr("to ") : qsTr("from ")) + msgSheet.user
            }
            layout: DockLayout {
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                topPadding: 70
                bottomPadding: 120
                layout: DockLayout {
                }
                verticalAlignment: VerticalAlignment.Fill
                CustomTextArea {
                    id: textToSend
                    background: Color.Green
                    verticalAlignment: VerticalAlignment.Fill
                    editable: msgSheet.editable
                }
            }
            Container {
                topPadding: 20
                bottomPadding: 20
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Bottom
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    property bool showButton: textToSend.text.length
                    onShowButtonChanged: {
                        sendButton.actived = showButton
                    }
                    horizontalAlignment: HorizontalAlignment.Left
                    preferredWidth: 350
                    CustomButton {
                        id: sendButton
                        horizontalAlignment: HorizontalAlignment.Left
                        preferredWidth: 350
                        text: qsTr("Send")
                        background: Color.Green
                        actived: textToSend.count
                        visible: msgSheet.editable
                        onClicked: {
                            _control.sendtext(index, textToSend.text);
                            msgSheet.close()
                        }
                    }
                }
                Container {
                    leftPadding: 40
                    horizontalAlignment: HorizontalAlignment.Right
                    CustomButton {
                        horizontalAlignment: HorizontalAlignment.Right
                        preferredWidth: 350
                        text: msgSheet.editable ? qsTr("Paste from clipboard") : qsTr("Copy to clipboard")
                        background: Color.Green
                        onClicked: {
                            if (msgSheet.editable) {
                                textToSend.text = textToSend.text + _control.copyFromClipboard()
                            } else {
                                notifyToast.show()
                                _control.copyToClipboard(textToSend.text)
                            }
                        }
                        attachedObjects: [
                            SystemToast {
                                id: notifyToast
                                body: "Copied to Clipboard"
                            }
                        ]
                    }
                }
            }
        }
    }
}