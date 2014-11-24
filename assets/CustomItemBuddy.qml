import bb.cascades 1.2

Container {
    property alias userName: mUserName.text
    property alias system: mSystem.text
    property alias userImage: imageTransition.userImage
    property alias avatarUrl: imageTransition.avatarUrl
    property alias plataformImage: imageTransition.plataformImage
    property alias themeColor: imageTransition.themeColor

    signal timeout()

    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    Container {
        CustomImageTransition {
            id: imageTransition
            //            userImage: "asset:///images/user.png"
            //plataformImage: "asset:///images/plataform.png"
            onCreationCompleted: {
                timeout.connect(changeImage);
            }
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 23
        }
    }
    Container {
        preferredHeight: 150
        layout: DockLayout {
        }
        Container {
            layout: DockLayout {
            }
            verticalAlignment: VerticalAlignment.Center
            Label {
                id: mUserName
                text: "Laairoy (You)"
                textStyle.fontSize: FontSize.Large
            }
            Container {
                    topPadding: 55
                Label {
                    id: mSystem
                    text: "at DesktopS"
                    textStyle.fontSize: FontSize.Medium
                }
            }
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 77
        }
    }
}