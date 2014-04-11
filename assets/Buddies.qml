import bb.cascades 1.2
import my.timer 1.0

NavigationPane {
    id: navPane
    Page {
        id: mPage
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: FreeFormTitleBarKindProperties {
                Container {
                    preferredHeight: 110
                    background: Color.create(_control.themeColor)
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: qsTr("Buddies")
                        textStyle {
                            base: SystemDefaults.TextStyles.TitleText
                            fontSize: FontSize.PointValue
                            fontSizeValue: 16
                            color: Color.White
                        }

                    }
                }
            }
        }
        Container {
            CustomItemBuddy {
                userName: "Laairoy (You)"
                system: "at Laai-Berry"
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
                                onCreationCompleted: {
                                    mlistItem.ListItem.view.timerToList.connect(timeout)
                                    themeColor = mlistItem.ListItem.view.themeColorToList
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
