import bb.cascades 1.2
import bb.cascades.pickers 1.0

Sheet {
    id: settingsSheet
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("Settings")
                closeButtonActive: true
            }
        }
        ScrollView {
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
                        background: Color.create(_control.themeColor)
                        ImageView {
                            property string buddyAvatar: _control.buddyAvatar
                            onBuddyAvatarChanged: {
                                imageSource = buddyAvatar
                            }
                            id: imgAvatar
                            imageSource: buddyAvatar
                            preferredHeight: 150
                            preferredWidth: 150
                        }
                    }
                    Button {
                        verticalAlignment: VerticalAlignment.Center
                        text: qsTr("Change Avatar")
                        onClicked: {
                            newAvatar.open()
                        }
                    }
                }
                Container {
                    topPadding: 30
                    Label {
                        text: qsTr("User name:")
                    }
                    TextField {
                        text: _control.buddyName
                        onTextChanging: {
                            _control.buddyName = text
                        }
                    }
                }
                Container {
                    topPadding: 30
                    Label {
                        text: qsTr("Save received file in:")
                    }
                    TextField {
                        text: "/donwloads"
                        enabled: false
                        backgroundVisible: true
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
                            background: Color.create(_control.themeColor)
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
        attachedObjects: [
            FilePicker {
                id: newAvatar
                type: FileType.Picture
                title: qsTr("Select Picture")
                imageCropEnabled: true
                directories: [ "/accounts/1000/" ]
                onFileSelected: {
                    _control.buddyAvatar = "file://" + selectedFiles
                    console.log("FileSelected signal received : " + selectedFiles);

                }
            }
        ]

    }
}