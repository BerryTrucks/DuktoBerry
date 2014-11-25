import bb.cascades 1.2

Container {
    property string number: "1"
    layout: StackLayout {
        orientation: LayoutOrientation.LeftToRight
    }
    Container {
        background: Color.White
        preferredHeight: 20
        preferredWidth: 20
        opacity: (number == "1") ? 1 : 0.4
    }
    Container {
        preferredWidth: 20
    }
    Container {
        background: Color.White
        preferredHeight: 20
        preferredWidth: 20
        opacity: (number == "2") ? 1 : 0.4
    }
    Container {
        preferredWidth: 20
    }
    Container {
        background: Color.White
        preferredHeight: 20
        preferredWidth: 20
        opacity: (number == "3") ? 1 : 0.4
    }
    Container {
        preferredWidth: 20
    }
    Container {
        background: Color.White
        preferredHeight: 20
        preferredWidth: 20
        opacity: (number == "4") ? 1 : 0.4
    }
}
