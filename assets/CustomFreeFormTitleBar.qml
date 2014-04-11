import bb.cascades 1.2

FreeFormTitleBarKindProperties {
    property alias title: lbTitle.text
    property alias closeButtonActive: closeButton.visible
    Container {
        layout: DockLayout {
        }
        background: Color.create(_control.themeColor)
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        ImageView {
            imageSource: "asset:///images/BottomShadow.png"
            opacity: 0.5
//            imageSource: "asset:///images/PanelGradient.png"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            
            
        }
        Container {
            leftPadding: 15
            rightPadding: 15
            preferredHeight: 110
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
                    id: lbTitle
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    textStyle {
                        base: SystemDefaults.TextStyles.TitleText
                        fontSize: FontSize.PointValue
                        fontSizeValue: 16
                        color: Color.White
                    }

                }
            }
            Container {
                id: closeButton
                visible: false
                verticalAlignment: VerticalAlignment.Center
                maxWidth: 150
                Button {
                    text: qsTr("Close")
                    onClicked: {
                        settingsSheet.close()
                    }
                }
            }
        }
    }
}
