import bb.cascades 1.2

FreeFormTitleBarKindProperties {
    id: freForm
    property alias title: lbTitle.text
    property alias closeButtonActive: closeButton.visible
    signal backButtonClicked
    Container {
        id: formContainer
        layout: DockLayout {
        }
        background: _control.themeColor
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        ImageView {
            //imageSource: "asset:///images/BottomShadow.png"
            opacity: 0.5
            //            imageSource: "asset:///images/PanelGradient.png"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

        }
        Container {
            layout: DockLayout {
            }
            preferredHeight: 110
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                Label {
                    id: lbTitle
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
                topPadding: 10
                bottomPadding: 10
                leftPadding: 10
                ImageView {
                    imageSource: "asset:///images/BackIcon.png"
                    scalingMethod: ScalingMethod.AspectFit
                    gestureHandlers: [
                        TapHandler {
                            onCreationCompleted: {
                                tapped.connect(freForm.backButtonClicked);
                            }
                        }
                    ]
                }
            }
        }
    }
}
