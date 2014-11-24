import bb.cascades 1.2

Dialog {
    id: reviewDialog
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
                    id: messageContainer
                    horizontalAlignment: HorizontalAlignment.Fill
                    topPadding: 20
                    Label {
                        id: lbText
                        text: "If you liked the application consider making a donation to support the developer."
                        textStyle {
                            color: Color.White
                            fontSize: FontSize.Large
                            textAlign: TextAlign.Justify
                        }
                        multiline: true
                    }
                    CustomButton {
                        horizontalAlignment: HorizontalAlignment.Center
                        preferredWidth: 400
                        implicitLayoutAnimationsEnabled: false
                        text: qsTr("Donate")
                        onClicked: {
//                            invokeBrowser.trigger("bb.action.OPEN")
                        }
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Bottom
                    bottomPadding: 20
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    CustomButton {
                        implicitLayoutAnimationsEnabled: false
                        text: qsTr("Remind me later")
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 50
                        }
                        onClicked: {
                            reviewDialog.close()
                        }
                    }
                    Container {
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 5
                        }
                    }
                    CustomButton {
                        implicitLayoutAnimationsEnabled: false
                        text: qsTr("Not show again")
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 50
                        }
                        onClicked: {
                            _control.showReviewOnsart = false
                            reviewDialog.close()
                        }
                    }
                }
            }
        }
    }
    attachedObjects: [
        Invocation {
            id: invokeBrowser
            query.invokeActionId: "bb.action.OPEN"
            query.invokeTargetId: "sys.browser"
            query.mimeType: "text/http"
            query.uri: "http://goo.gl/cEwC1w"
        }
    ]
}