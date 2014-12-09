import bb.cascades 1.2
import bb.system 1.0

Sheet {
    id: msgSheet
    property variant index
    property string user: ""
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
        ScrollView {

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
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 50
                        }
                        property bool showButton: textToSend.text.length
                        onShowButtonChanged: {
                            sendButton.actived = showButton
                        }
                        horizontalAlignment: HorizontalAlignment.Left
                        CustomButton {
                            id: sendButton
                            horizontalAlignment: HorizontalAlignment.Fill
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
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 2
                        }
                    }
                    Container {
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 50
                        }
                        horizontalAlignment: HorizontalAlignment.Fill
                        CustomButton {
                            horizontalAlignment: HorizontalAlignment.Fill
                            //preferredWidth:
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
}