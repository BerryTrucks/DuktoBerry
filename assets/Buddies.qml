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
            CustomItemBuddy {
                userName: _control.buddyName + qsTr(" (You)")
                system: "at Laai-Berry"
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
                                avatarUrl: ListItemData.avatar
                                plataformImage: ListItemData.oslogo
                                    themeColor: mlistItem.ListItem.view.themeColorToList
                                onCreationCompleted: {
                                    mlistItem.ListItem.view.timerToList.connect(timeout)
                                    console.log("testes",mlistItem.ListItem.view.toString())
                                    
                                }
                            }
                        }
                    ]
                    onTriggered: {
                        var item = dataModel.data(indexPath)
                        var sendData = sendDataPane.createObject();
                        sendData.userName = item.username
                        sendData.system = item.system
                        sendData.avatarUrl = item.avatar
                        sendData.plataformImage = item.oslogo
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
