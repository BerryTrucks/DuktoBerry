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
                title: qsTr("Select Buddies")
                closeButtonActive: true
                onBackButtonClicked: {
                    navPane.pop()
                }
            }
        }
        Container {
            topPadding: 20
            leftPadding: 20
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                Label {
                    text: "dddd " + _control.forTest
                }
            }
            Container {
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
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
                            topPadding: 55
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
                    horizontalAlignment: HorizontalAlignment.Fill
                    //topPadding: 30
                    ListView {
                        horizontalAlignment: HorizontalAlignment.Fill
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
                                    preferredWidth: 1440
                                    layout: DockLayout {
                                    }
                                    topPadding: 30
                                    CustomItemBuddy {
                                        horizontalAlignment: HorizontalAlignment.Fill
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
                            _control.sendWithCard(dataModel.data(indexPath))
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
        }
    ]
    onCreationCompleted: {
        timer.start()
        _control.transferStart.connect(openProgressDialog)
        if (_control.showTermsOnStart) {
            tempsPane.createObject().open()
        }
    }
    
    function openProgressDialog() {
        progressDialog.createObject().open()
    }
}
