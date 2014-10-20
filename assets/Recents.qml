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
            topPadding: 100
            leftPadding: 20
            rightPadding: 20
            visible: false
            Label {
                text: qsTr("Sorry, no data has been received yet...")
                textStyle.fontSize: FontSize.XXLarge
                multiline: true
            }
        }
        Container {
            ListView {
                id: listview
                rootIndexPath: [ 0 ]
                dataModel: _control.recentModel
                
                onTriggered: {
                    var item = dataModel.data(indexPath);
                    if(item.type == "text"){
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
                        StandardListItem {
                            imageSource: ListItemData.typeIcon
                            title: ListItemData.type
                            description: qsTr("from ") + ListItemData.sender + ", " + ListItemData.dateTime
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
