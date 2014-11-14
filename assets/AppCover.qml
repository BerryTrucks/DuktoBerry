import bb.cascades 1.2

Container {
    layout: DockLayout {
    }
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    background: Color.create(_controlCover.themeColor)
    ImageView {
        preferredHeight: 250
        preferredWidth: 250
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center
        imageSource: "asset:///images/DuktoMetroIcon.png"
    }
}