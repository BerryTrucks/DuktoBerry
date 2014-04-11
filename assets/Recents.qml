import bb.cascades 1.2

Page {
    titleBar: TitleBar {
        kind: TitleBarKind.FreeForm
        kindProperties: CustomFreeFormTitleBar {
                title: qsTr("Recents")
                closeButtonActive: false
            }
    }
    Container {
        layout: DockLayout {
        }
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        Container {
            topPadding: 100
            leftPadding: 20
            rightPadding: 20
            Label {
                text: "Sorry, no data has been received yet..."
                textStyle.fontSize: FontSize.XXLarge
                multiline: true
            }
        }
    }
}
