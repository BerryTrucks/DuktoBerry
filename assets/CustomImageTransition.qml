import bb.cascades 1.2

Container {
    property string plataformImage
    property string userImage
    property string themeColor: _control.themeColor
    signal changeImage()
    onChangeImage: {
        animationStart.play();
        if (userImage == imgTrasition.imageSource) {
            imgTrasition.imageSource = plataformImage;
        } else {
            imgTrasition.imageSource = userImage
        }
        animationEnd.play();
    }
    Container {
        layout: DockLayout {
        }
        preferredHeight: 150
        preferredWidth: 150
        background: Color.create(themeColor)
        ImageView {
            id: imgTrasition
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            imageSource: userImage
            maxWidth: 150
            maxHeight: 150

        }
    }
    attachedObjects: [
        SequentialAnimation {
            id: animationStart
            animations: [
                ScaleTransition {
                    toY: -1
                    duration: 150
                },
                ScaleTransition {
                    toY: 0
                    duration: 150

                }

            ]

        },
        SequentialAnimation {
            id: animationEnd
            animations: [
                ScaleTransition {
                    toY: 0
                    duration: 150

                },
                ScaleTransition {
                    toY: 1
                    duration: 150
                }

            ]

        }
    ]
}
