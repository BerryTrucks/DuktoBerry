import bb.cascades 1.2
import my.timer 1.0

NavigationPane {
    id: navPane
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
            CustomItemBuddy {
                userName: _control.buddyName + " (You)"
                system: "at Laai-Berry"
                userImage: _control.buddyAvatar
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
                    background: Color.create(_control.themeColor)
                    Divider {
                    }
                }
            }
            Container {
                topPadding: 30
                ListView {
                    property string themeColorToList: _control.themeColor
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
                            CustomItemBuddy {
                                id: mlistItem
                                userName: ListItemData.username
                                system: ListItemData.system
                                plataformImage: ListItemData.oslogo
                                    themeColor: mlistItem.ListItem.view.themeColorToList
                                onCreationCompleted: {
                                    mlistItem.ListItem.view.timerToList.connect(timeout)
                                }
                            }
                        }
                    ]
                    onTriggered: {
                        var sendData = sendDataPane.createObject();
                        sendData.index = dataModel.data(indexPath)
                        navPane.push(sendData)
                    }
                }
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: sendDataPane
            SendData {
            }
        },
        QTimer {
            id: timer
            interval: 5000
        }
    ]
    onCreationCompleted: {
        timer.start()
    }
}
