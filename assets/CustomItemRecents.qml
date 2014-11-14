import bb.cascades 1.2

Container {
    property string themeColor
    property alias title: titleLabel.text
    property alias description: descriptionLabel.text
    property alias imageSource: image.imageSource
    topPadding: 20
    leftPadding: 20

    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    Container {
        layout: DockLayout {
        }
        id: imageBackground
        preferredHeight: 100
        preferredWidth: 100
        background: Color.create(themeColor)
        ImageView {
            id: image
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            imageSource: "asset:///images/RecentText.png"
            scalingMethod: ScalingMethod.AspectFill

        }
    }
    Container {
        leftPadding: 20
        preferredHeight: 100
        //        background: Color.Green
        layout: DockLayout {
        }
        Label {
            id: titleLabel
            text: "ola mundo"
            textStyle.fontSize: FontSize.Large
        }
        Container {

            topPadding: 45
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
