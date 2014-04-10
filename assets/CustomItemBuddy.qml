import bb.cascades 1.2

Container {
    property alias userName: mUserName.text
    property alias system: mSystem.text
    property alias userImage: imageTransition.userImage
    property alias plataformImage: imageTransition.plataformImage
    leftPadding: 20
    topPadding: 20
    signal timeout()

    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    Container {
        CustomImageTransition {
            id: imageTransition
            userImage: "asset:///images/user.png"
            plataformImage: "asset:///images/plataform.png"
            onCreationCompleted: {
                timeout.connect(changeImage);
            }
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 23
        }
    }
    Container {
        Label {
            id: mUserName
            text: "Laairoy (You)"
            textStyle.fontSize: FontSize.Large
        }
        Label {
            id: mSystem
            text: "at DesktopS"
            textStyle.fontSize: FontSize.Medium
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 77
        }
    }
}