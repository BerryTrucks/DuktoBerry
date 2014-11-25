import bb.cascades 1.2

Sheet {
    id: mIntroSheet
    Page {
        Container {
            background: _control.themeColor
            layout: DockLayout {
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                topPadding: 50
                horizontalAlignment: HorizontalAlignment.Center
                leftPadding: 50
                rightPadding: 50
                implicitLayoutAnimationsEnabled: false
                Label {
                    id: mIntroLabel
                    implicitLayoutAnimationsEnabled: false
                    text: "Share to any Device"
                    multiline: true
                    textStyle{
                        textAlign: TextAlign.Center
                        fontSize: FontSize.XLarge
                        color: Color.White
                        fontWeight: FontWeight.Bold
                    }
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                ListView {
                    preferredWidth: 768
                    preferredHeight: 900
                    id: listview
                    flickMode: FlickMode.SingleItem
                    snapMode: SnapMode.LeadingEdge
                    scrollIndicatorMode: ScrollIndicatorMode.None

                    layout: StackListLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    dataModel: XmlDataModel {
                        source: "asset:///XML/intro.xml"
                    }
                    listItemComponents: [
                        ListItemComponent {
                            type: "intro"
                            Container {
                                preferredWidth: 768
                                preferredHeight: 900
                                leftPadding: 50
                                rightPadding: 50
                                layout: DockLayout {
                                }
                                verticalAlignment: VerticalAlignment.Fill
                                Container {
                                    verticalAlignment: VerticalAlignment.Center
                                ImageView {
                                    imageSource: ListItemData.imageSource
                                    scalingMethod: ScalingMethod.AspectFit
                                    }
                                }
                            }
                        }
                    ]
                    attachedObjects: [
                        // This handler is tracking the scroll state of the ListView.
                        ListScrollStateHandler {
                            onFirstVisibleItemChanged: {
                                var item = listview.dataModel.data(firstVisibleItem)
                                mIntroLabel.text = item.text
                            }
                        }
                    ]
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Bottom
                horizontalAlignment: HorizontalAlignment.Center
                bottomPadding: 20
                CustomButton {
                    preferredWidth: 400
                    background: Color.Green
                    horizontalAlignment: HorizontalAlignment.Center
                    text: qsTr("Skip Intro")
                    onClicked: {
                        mIntroSheet.close()
                    }
                }
            }
        }
    }
}