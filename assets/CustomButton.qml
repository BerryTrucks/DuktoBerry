import bb.cascades 1.2
Container {
    id: rootContainer
    signal clicked
    property alias text: lblButton.text
    maxHeight: 80
    layout: DockLayout {
    }
    Container {
        layout: DockLayout {
        }
        id: btnContainer
        background: Color.create(_control.themeColor)
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
        defaultImageSource: "asset:///images/customButtom.png"
        horizontalAlignment: HorizontalAlignment.Fill
        onCreationCompleted: {
            clicked.connect(rootContainer.clicked)
        }
        onTouch: {
            if (event.isDown()) {
                colorContainer.opacity = 0.5
            } else if (event.isUp()) {
                colorContainer.opacity = 100
            }
        }
    }
}