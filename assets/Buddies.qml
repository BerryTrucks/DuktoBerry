import bb.cascades 1.2

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
                        text: "Buddies"
                        textStyle {
                            base: SystemDefaults.TextStyles.TitleText
                            fontSize: FontSize.PointValue
                            fontSizeValue: 16
                        }

                    }
                }
            }
        }
    }
    Container {
        Container {
            leftPadding: 20
            topPadding: 20
            StandardListItem {
                imageSource: "asset:///images/tux.jpg"
                title: "Laairoy" + " (you)"
                description: "at DesktopS"
            }
            //            layout: StackLayout {
            //                orientation: LayoutOrientation.LeftToRight
            //            }
            //            Container {
            //                ImageView {
            //                    maxWidth: 300
            //                    maxHeight: 300
            //                    imageSource: "asset:///images/tux.jpg"
            //                }
            //            }
            //            Container {
            //                verticalAlignment: VerticalAlignment.Center
            //                Label {
            //                    text: "Laairoy (You)"
            //                    textStyle.fontSize: FontSize.Large
            //                }
            //                Label {
            //                    text: "at DesktopS"
            //                    textStyle.fontSize: FontSize.Medium
            //                }
            //            }
        }
        Container {
            topPadding: 30
            leftPadding: 100
            rightPadding: 100
            Container {
                background: Color.create("#30910e")
                Divider {
                }
            }
        }
        Container {
            topPadding: 30
            ListView {
                id: listview
                rootIndexPath: [ 0 ]
                dataModel: _control.buddyModel
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        StandardListItem {
                            imageSpaceReserved: true
                            title: ListItemData.username
                            description: ListItemData.platform
                        }
                    }
                ]
            }
        }
    }
}
