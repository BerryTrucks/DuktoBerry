import bb.cascades 1.2

FreeFormTitleBarKindProperties {
    id: freForm
    property alias title: lbTitle.text
    property alias closeButtonActive: closeButton.visible
    signal backButtonClicked
    Container {
        layout: DockLayout {
        }
        background: _control.themeColor
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
            layout: DockLayout {
            }
            leftPadding: 15
            rightPadding: 15
            preferredHeight: 110
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Fill
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
                ImageButton {
                    //                    text: qsTr("Close")
                    defaultImageSource: "asset:///images/BackIcon.png"
                    pressedImageSource: "asset:///images/BackIconPress.png"
                    onClicked: {
                        
                    }
                    onCreationCompleted: {
                        clicked.connect(freForm.backButtonClicked)
                    }
                }
            }
        }
    }
}
