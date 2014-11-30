import bb.cascades 1.2
Container {
    id: rootContainer
    signal clicked
    property alias text: lblButton.text
    property bool actived: true
    maxHeight: 80
    layout: DockLayout {
    }
    Container {
        layout: DockLayout {
        }
        id: btnContainer
        background: _control.themeColor
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        topPadding: 6
        rightPadding: 6
        leftPadding: 6
        bottomPadding: 6
        ImageButton {
            id: imgButton
            preferredHeight: 80
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            defaultImageSource: "asset:///images/button.png"
            pressedImageSource: "asset:///images/buttonPressed.png"
            disabledImageSource: "asset:///images/button.png"
            onCreationCompleted: {
                clicked.connect(rootContainer.clicked)
            }
        }
    }
    Label {
        id: lblButton
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        touchPropagationMode: TouchPropagationMode.None
        text: "Button"
        textStyle.color: btnContainer.background
    }
    onActivedChanged: {
        if (actived) {
            btnContainer.background = _control.themeColor;
            imgButton.opacity = 1
        } else {
            btnContainer.background = Color.Gray
            imgButton.opacity = 0.5
        }
        imgButton.enabled = actived
    }
}