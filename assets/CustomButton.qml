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
        background: rootContainer.actived ? Color.create(_control.themeColor) : Color.Gray
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        topPadding: 6
        rightPadding: 6
        leftPadding: 6
        bottomPadding: 6
        Container {
            id: colorContainer
            background: Color.White
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            opacity: rootContainer.actived ? 1.0 : 0.5

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
    ImageButton {
        preferredHeight: 80
        horizontalAlignment: HorizontalAlignment.Fill
//        defaultImageSource: "asset:///images/customButtom.png"
        onCreationCompleted: {
            clicked.connect(rootContainer.clicked)
        }
        enabled: rootContainer.actived
        onTouch: {
            if (event.isDown() && rootContainer.actived) {
                colorContainer.opacity = 0.5
            } else if (event.isUp() && rootContainer.actived) {
                colorContainer.opacity = 1
            }
        }
    }
}