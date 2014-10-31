import bb.cascades 1.2

Container {
    property string color: "#30910e"
    layout: DockLayout {
    }
    preferredHeight: 100
    preferredWidth: 120
    Container {
        id: colorContainer
        horizontalAlignment: HorizontalAlignment.Center
        preferredHeight: 80
        preferredWidth: 80
        background: Color.create(color)
        onTouch: {
            if (event.isUp()) {
                _control.themeColor = color
            }
        }
    }
}
