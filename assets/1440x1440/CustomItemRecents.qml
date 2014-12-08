import bb.cascades 1.2

Container {
    property variant themeColor
    property alias title: titleLabel.text
    property alias description: descriptionLabel.text
    property alias imageSource: image.imageSource
    topPadding: 20
    leftPadding: 20
    rightPadding: 20
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    Container {
        layout: DockLayout {
        }
        id: imageBackground
        preferredHeight: 130
        preferredWidth: 130
        background: themeColor
        ImageView {
            id: image
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            imageSource: "asset:///images/RecentText.png"
            scalingMethod: ScalingMethod.AspectFill

        }
    }
    Container {
        verticalAlignment: VerticalAlignment.Center
        leftPadding: 20
        //background: Color.Green
        layout: DockLayout {
        }
        Container {
            Label {
                id: titleLabel
                text: "ola mundo"
                textStyle.fontSize: FontSize.Large
            }
        }
        Container {
            topPadding: 55
            Label {
                id: descriptionLabel
                text: "ola mundo"
                textStyle {
                    color: Color.Gray
                    fontSize: FontSize.Small
                }
            }
        }
    }
}
