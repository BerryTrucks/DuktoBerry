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
                    CustomImageTransition {
                        background: Color.Green
                        userImage: "images/DuktoMetroIcon.png"
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: DockLayout {
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "Dukto"
                        textStyle.fontSize: FontSize.XXLarge
                    }
                    Container {
                        topPadding: 75
                        Label {
                            text: "by Emanuele Colombo"
                            textStyle {
                                color: Color.Gray
                                fontSize: FontSize.XXSmall
                            }
                        }
                    }
                }
                Container {
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: DockLayout {
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "Developer (BlackBerry)"
                    }
                    Container {
                        topPadding: 40
                        horizontalAlignment: HorizontalAlignment.Center
                        Label {
                            text: "Marden Laairoy"
                            textStyle {
                                fontSize: FontSize.Large
                                fontStyle: FontStyle.Italic
                                color: _control.themeColor
                            }
                        }
                    }
                }
                Container {
                    topPadding: 30
                    leftPadding: 100
                    rightPadding: 100
                    Container {
                        background: _control.themeColor
                        Divider {
                        }
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
                Label {
                    text: "http://msec.it/dukto/"
                    textStyle {
                        fontSize: FontSize.Small
                        color: Color.Blue

                    }
                }
                Container {
                    topPadding: 20
                    horizontalAlignment: HorizontalAlignment.Center
                    CustomButton {
                        preferredWidth: 500
                        background: Color.Green
                        text: "Donate"
                        onClicked: {
                            dotateDialog.createObject().open()
                        }

                    }
                    Container {
                        topPadding: 20
                        CustomButton {
                            preferredWidth: 500
                            background: Color.Green
                            text: qsTr("Rate App")
                            onClicked: {
                                reviewApp.trigger("bb.action.OPEN")
                            }
                        }

                    }
                    Container {
                        topPadding: 20
                        CustomButton {
                            preferredWidth: 500
                            background: Color.Green
                            text: qsTr("Contact me")
                            onClicked: {
                                sendMail.trigger("bb.action.SENDEMAIL")
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
                    },
                    ComponentDefinition {
                        id: dotateDialog
                        DonateDialog {
                        }
                    },
                    Invocation {
                        id: sendMail
                        query {
                            invokeTargetId: "sys.pim.uib.email.hybridcomposer"
                            invokeActionId: "bb.action.SENDEMAIL"
                            uri: "mailto:marden.laairoy@gmail.com?subject=Dukto Support"
                        }
                    },
                    Invocation {
                        id: reviewApp
                        query {
                            invokeTargetId: "sys.appworld"
                            invokeActionId: "bb.action.OPEN"
                            uri: "appworld://content/59945056"
                        }
                    }

                ]
            }
        }
    }
}