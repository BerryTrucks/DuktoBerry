import bb.cascades 1.2

Dialog {
    id: progressDialog
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
            background: Color.create(_control.themeColor)
            leftPadding: 30
            rightPadding: 30
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                topPadding: 20
                Label {
                    text: "Sending data"
                    textStyle {
                        fontSize: FontSize.XXLarge
                        color: Color.White
                    }
                }
                Label {
                    text: "to" + "Laairoy"
                    textStyle.color: Color.White
                }
                Container {
                    id: progress
                    layout: DockLayout {
                    }
                    preferredHeight: 100
                    background: Color.White
                    preferredWidth: 700
                    opacity: 0.5
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
                    Button {
                        horizontalAlignment: HorizontalAlignment.Right
                        preferredWidth: 200
                        text: qsTr("Abort")
                        onClicked: {
                            _control.abortTransfer()
                            progressDialog.close()
                        }
                    }
                }
            }
        }
    }
}