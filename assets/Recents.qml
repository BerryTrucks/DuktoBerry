import bb.cascades 1.2

Page {
    titleBar: TitleBar {
        kind: TitleBarKind.FreeForm
        kindProperties: CustomFreeFormTitleBar {
            title: qsTr("Recents")
            closeButtonActive: false
        }
    }
    Container {
        layout: DockLayout {
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        Container {
            leftPadding: 20
            rightPadding: 20
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            visible: ! _control.countRecents
            Label {
                text: qsTr("No data has been received")
                textStyle {
                    fontSize: FontSize.Large
                    fontWeight: FontWeight.Bold
                }
                multiline: true
            }
        }
        Container {
            visible: _control.countRecents
            ListView {
                property variant themeColor: _control.themeColor
                id: listview
                rootIndexPath: [ 0 ]
                dataModel: _control.recentModel

                onTriggered: {
                    var item = dataModel.data(indexPath);
                    if (item.type == "text") {
                        var openItem = openText.createObject();
                        openItem.text = item.value
                        openItem.user = item.sender
                        openItem.editable = false
                        openItem.open()

                    }
                }
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        CustomItemRecents {
                            id: mlistItem
                            onCreationCompleted: {
                                console.log("testesssssss")
                            }
                            imageSource: ListItemData.typeIcon
                            title: ListItemData.type
                            description: qsTr("from ") + ListItemData.sender + ", " + ListItemData.dateTime
                            themeColor: mlistItem.ListItem.view.themeColor
                        }
                    }
                ]
                attachedObjects: [
                    ComponentDefinition {
                        id: openText
                        MessagePage {
                        }
                    }
                ]
            }
        }
    }
}
