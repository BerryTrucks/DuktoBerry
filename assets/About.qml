import bb.cascades 1.2

Sheet {
    id: aboutSheet
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("About")
                closeButtonActive: true
                onBackButtonClicked: {
                    aboutSheet.close()
                }
            }
        }
        ScrollView {
            Container {
                leftPadding: 20
                rightPadding: 20
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    topPadding: 20
                    leftPadding: 20
                    CustomImageTransition {
                        background: Color.Green
                        userImage: "images/DuktoMetroIcon.png"
                    }
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center
                    text: "Dukto BlackBerry"
                    textStyle.fontSize: FontSize.XXLarge
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center
                    text: "Developers"
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center
                    text: "Marden Laairoy"
                    textStyle {
                        fontSize: FontSize.Large
                        fontStyle: FontStyle.Italic
                        color: Color.create(_control.themeColor)
                    }
                }
                Container {
                    topPadding: 30
                    leftPadding: 100
                    rightPadding: 100
                    Container {
                        background: Color.create(_control.themeColor)
                        Divider {
                        }
                    }
                }
                Label {
                    text: "http://msec.it/dukto/"
                    textStyle {
                        fontSize: FontSize.Small
                        color: Color.Blue

                    }
                }
                Label {
                    text: "This application and it's source code are released freely as open source project."
                    multiline: true
                    textStyle {
                        fontSize: FontSize.Small
                        color: Color.Gray
                    }
                }
                Container {
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                    CustomButton {
                        preferredWidth: 400
                        background: Color.Green
                        text: "Donate with Paypal"
                        onClicked: {
                            invokeBrowser.trigger("bb.action.OPEN")
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
        }
    }
}