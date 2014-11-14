import bb.cascades 1.2

Container {
    id: rootContainer
    property alias text: txtField.text
    property alias hintText: txtField.hintText
    property alias txtenabled: txtField.enabled
    property string themeColor: _control.themeColor
    layout: DockLayout {
    }
    maxHeight: 80
    Container {
        id: colorContainer
        layout: DockLayout {
        }
        background: Color.Gray
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        leftPadding: 5
        rightPadding: 5
        topPadding: 5
        bottomPadding: 5
        Container {
            id: whiteContainer
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            background: Color.White
        }
    }
    TextField {
        id: txtField
        backgroundVisible: false
        enabled: true
    }
    onCreationCompleted: {
        if(!txtenabled){
            whiteContainer.visible = false
            txtField.textStyle.color = Color.White
            colorContainer.background = themeColor
        }
    }
    onThemeColorChanged: {
        if(!txtenabled){
            colorContainer.background = themeColor
        }
    }
}
