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
                text: "Sorry, no data has been received yet..."
                textStyle.fontSize: FontSize.XXLarge
                multiline: true
            }
        }
        Container {
            ListView {
                id: listview
                rootIndexPath: [ 0 ]
                dataModel: _control.recentModel
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            imageSource: ListItemData.typeIcon
                            title: ListItemData.type
                            description: "from " + ListItemData.sender + ", " + ListItemData.dateTime
                        }
                    }
                ]
            }
        }
    }
}
