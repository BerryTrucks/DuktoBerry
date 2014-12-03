import bb.cascades 1.2

Dialog {
    id: progressDialog
    property string userName: _control.currentTransferBuddy
    property bool transferSending: _control.currentTransferSending
    Container {
        layout: DockLayout {
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            background: Color.White
            opacity: 0.8
        }
        Container {
            layout: DockLayout {
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Center
                preferredHeight: 450
                background: _control.themeColor
                leftPadding: 30
                rightPadding: 30
                Container {
                    id: progressContainer
                    horizontalAlignment: HorizontalAlignment.Fill
                    topPadding: 20
                    visible: ! messageContainer.visible
                    Label {
                        text: (transferSending) ? qsTr("Sending data") : qsTr("Receiving data")
                        textStyle {
                            fontSize: FontSize.XXLarge
                            color: Color.White
                        }
                    }
                    Label {
                        text: ((transferSending) ? qsTr("to ") : qsTr("from ")) + userName
                        textStyle.color: Color.White
                    }
                    Container {
                        layout: DockLayout {
                        }
                        Container {
                            id: progress
                            layout: DockLayout {
                            }
                            horizontalAlignment: HorizontalAlignment.Left
                            preferredHeight: 100
                            background: Color.White
                            preferredWidth: _control.displaySizeWidth() - 60
                            opacity: 0.5
                        }
                        Container {
                            verticalAlignment: VerticalAlignment.Fill
                            background: Color.White
                            preferredWidth: (progress.preferredWidth / 100) * _control.currentTransferProgress
                        }
                    }
                    Container {
                        topPadding: 30
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        Label {
                            text: _control.currentTransferStats
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 8
                            }
                            verticalAlignment: VerticalAlignment.Center
                            textStyle.color: Color.White
                        }
                    }
                }
                Container {
                    id: messageContainer
                    horizontalAlignment: HorizontalAlignment.Fill
                    topPadding: 20
                    visible: false
                    Label {
                        id: lbTitle
                        textStyle {
                            fontSize: FontSize.XXLarge
                            color: Color.White
                        }
                    }
                    Label {
                        topPadding: 20
                        id: lbText
                        textStyle {
                            color: Color.White
                        }
                        multiline: true
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Right
                    verticalAlignment: VerticalAlignment.Bottom
                    bottomPadding: 20
                    CustomButton {
                        id: cbClose
                        preferredWidth: 200
                        background: Color.Green
                        visible: transferSending
                        implicitLayoutAnimationsEnabled: false
                        text: "Abort"    
                        onClicked: {
                            _control.abortTransfer()
                            progressDialog.close()
                        }
                    }
                }
            }
        }
    }
    function receiveCompleted() {
        console.log("Receive File completed")
        progressDialog.close()
    }
    function messagePage(pageTitle, pageText) {
        lbTitle.text = pageTitle
        lbText.text = pageText
        cbClose.text = "Close"
        if(pageTitle == "Error"){
            cbClose.text = "Close"
            cbClose.visible = true
        }

        messageContainer.visible = true
    }
    onCreationCompleted: {
        _control.receiveCompleted.connect(progressDialog.receiveCompleted)
        _control.gotoMessagePage.connect(progressDialog.messagePage)
    }
}