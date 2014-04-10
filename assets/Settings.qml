import bb.cascades 1.2

Sheet {
    id: settingsSheet
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: FreeFormTitleBarKindProperties {
                Container {
                    leftPadding: 15
                    rightPadding: 15
                    preferredHeight: 110
                    background: Color.create("#30910e")
                    horizontalAlignment: HorizontalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Fill
                        layoutProperties: StackLayoutProperties {
                            spaceQuota: 8
                        }
                        Label {
                            verticalAlignment: VerticalAlignment.Center
                            horizontalAlignment: HorizontalAlignment.Center
                            text: qsTr("Settings")
                            textStyle {
                                base: SystemDefaults.TextStyles.TitleText
                                fontSize: FontSize.PointValue
                                fontSizeValue: 16
                                color: Color.White
                            }

                        }
                    }
                    Container {
                        verticalAlignment: VerticalAlignment.Center
                        maxWidth: 150
                        Button {
                            text: qsTr("Close")
                            onClicked: {
                                settingsSheet.close()
                            }
                        }
                    }
                }
            }
        }
        Container {
            topPadding: 20
            leftPadding: 20
            rightPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    background: Color.create("#30910e")
                    ImageView {
                        preferredHeight: 150
                        preferredWidth: 150
                        imageSource: "asset:///images/user.png"
                    }
                }
                Button {
                    verticalAlignment: VerticalAlignment.Center
                    text: qsTr("Change Avatar")
                }
            }
            Container {
                topPadding: 30
                Label {
                    text: qsTr("User name:")
                }
                TextField {
                    text: "Laairoy"
                }
            }
            Container {
                topPadding: 30
                Label {
                    text: qsTr("Save received file in:")
                }
                TextField {
                    text: "/donwloads"
                }
                Button {
                	horizontalAlignment: HorizontalAlignment.Right
                    text: qsTr("Change folder")
                }
            }
            Container {
                topPadding: 30
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                Label {
                    text: qsTr("Theme Color:")
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Fill
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        preferredHeight: 200
                        preferredWidth: 200
                        background: Color.create("#30910e")
                    }
                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Center
                        leftPadding: 40
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Container {
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#30910e")
                            }
                            Container {
                                leftPadding: 20
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#b01717")
                            }
                            Container {
                                leftPadding: 20
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#5782c6")
                            }
                            Container {
                                leftPadding: 20
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#42484a")
                            }
                        }
                        Container {
                            topPadding: 20
                            horizontalAlignment: HorizontalAlignment.Fill
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            Container {
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#c08aa1")
                            }
                            Container {
                                leftPadding: 20
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#4f546c")
                            }
                            Container {
                                leftPadding: 20
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#fc982b")
                            }
                            Container {
                                leftPadding: 20
                                preferredHeight: 80
                                preferredWidth: 80
                                background: Color.create("#914994")
                            }
                        }
                    }

                }
            }

        }
    }
}