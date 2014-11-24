import bb.cascades 1.2
import my.timer 1.0

NavigationPane {
    id: navPane
    backButtonsVisible: false
    Page {
        id: mPage
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("Buddies")
                closeButtonActive: false
            }
        }
        Container {
            topPadding: 20
            leftPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            CustomItemBuddy {
                userName: _control.buddyName + qsTr(" (You)")
                system: "at " + _control.getHostName()
                userImage: _control.buddyAvatar
                avatarUrl: ""
                plataformImage: "asset:///images/BlackberryLogo.png"
                onCreationCompleted: {
                    timer.timeout.connect(timeout);
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
            Container {
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill
                Container {
                    id: msgContainer
                    topPadding: 150
                    visible: ! _control.countBuddy
                    horizontalAlignment: HorizontalAlignment.Center
                    Container {
                        layout: DockLayout {
                        }
                        Label {
                            horizontalAlignment: HorizontalAlignment.Center
                            text: qsTr("No buddies found")
                            textStyle {
                                fontSize: FontSize.Large
                                fontWeight: FontWeight.Bold
                            }
                        }
                        Container {
                            topPadding: 50
                            bottomPadding: 10
                            Label {
                                horizontalAlignment: HorizontalAlignment.Center
                                text: qsTr("Open Dukto in another device")
                                textStyle {
                                    fontSize: FontSize.Small
                                    color: Color.Gray
                                }
                            }
                        }
                    }
                    ImageView {
                        id: waitingImage
                        horizontalAlignment: HorizontalAlignment.Center
                        preferredHeight: 10
                        scalingMethod: ScalingMethod.AspectFit
                        imageSource: "asset:///images/waiting.gif"
                        attachedObjects: [
                            ImageAnimator {
                                id: imageAnimator
                                animatedImage: waitingImage.image
                                started: msgContainer.visible
                            }
                        ]
                    }
                }
                Container {
                    visible: _control.countBuddy
                    Container {
                        //topPadding: 30
                        ListView {
                            property variant themeColorToList: _control.themeColor
                            signal timerToList()
                            onCreationCompleted: {
                                timer.timeout.connect(timerToList);
                            }

                            id: listview
                            rootIndexPath: [ 0 ]
                            dataModel: _control.buddyModel
                            listItemComponents: [
                                ListItemComponent {
                                    type: "item"
                                    Container {
                                        id: mlistItem
                                        layout: DockLayout {
                                        }
                                        topPadding: 30
                                        CustomItemBuddy {
                                            userName: ListItemData.username
                                            system: ListItemData.system
                                            avatarUrl: ListItemData.avatar
                                            userImage: ListItemData.avatar
                                            plataformImage: ListItemData.oslogo
                                            themeColor: mlistItem.ListItem.view.themeColorToList
                                            onCreationCompleted: {
                                                mlistItem.ListItem.view.timerToList.connect(timeout)
                                            }
                                        }
                                    }
                                }
                            ]
                            onTriggered: {
                                var item = dataModel.data(indexPath);
                                var sendData = sendDataPane.createObject();

                                sendData.userName = item.username.toString()
                                sendData.system = item.system.toString()
                                sendData.avatarUrl = item.avatar.toString()
                                sendData.index = dataModel.data(indexPath)

                                navPane.push(sendData)
                            }
                        }
                    }
                }
            }
        }
    }
    attachedObjects: [
        QTimer {
            id: timer
            interval: 5000
        },
        ComponentDefinition {
            id: sendDataPane
            SendData {
            }
        }
    ]
    onCreationCompleted: {
        timer.start()
    }
}
