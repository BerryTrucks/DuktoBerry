import bb.cascades 1.2
import bb.platform 1.2

Sheet {
    id: mDonate
    Page {
        attachedObjects: [
            PaymentManager {
                id: digitalGoodPaymentManager
                onPurchaseFinished: {
                    if (reply.errorCode == 0) {
                        // Store this purchase to keep track
                        // of the purchases made by the user.
                    } else {
                        console.log("Error: " + reply.errorInfo);
                    }
                }
            }
        ]
        Container {
            layout: DockLayout {
            }
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            Container {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                background: Color.White
                opacity: 0.8
            }
            Container {
                layout: DockLayout {
                }
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                Container {
                    layout: DockLayout {
                    }
                    horizontalAlignment: HorizontalAlignment.Fill
                    verticalAlignment: VerticalAlignment.Center
                    preferredHeight: 450
                    background: _control.themeColor
                    leftPadding: 30
                    rightPadding: 30
                    Container {
                        id: messageContainer
                        horizontalAlignment: HorizontalAlignment.Fill
                        topPadding: 20
                        Label {
                            id: lbText
                            text: qsTr("Select the amount you wish to donate. You can donate as many times as you want.")
                            textStyle {
                                color: Color.White
                                fontSize: FontSize.Large
                                textAlign: TextAlign.Justify
                            }
                            multiline: true
                        }
                        Container {
                            horizontalAlignment: HorizontalAlignment.Center
                            topPadding: 20
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            CustomButton {
                                preferredWidth: 100
                                implicitLayoutAnimationsEnabled: false
                                text: "0.99"
                                onClicked: {
                                    //digitalGoodPaymentManager.requestPurchase("", digitalGood.sku, digitalGood.name); 
                                    digitalGoodPaymentManager.requestPurchase("", "SKU59946728", "donate0.99"); 
                                }
                            }
                            CustomButton {
                                preferredWidth: 100
                                implicitLayoutAnimationsEnabled: false
                                text: "1.99"
                                onClicked: {
                                    digitalGoodPaymentManager.requestPurchase("", "SKU59946729", "donate1.99");
                                }
                            }
                            CustomButton {
                                preferredWidth: 100
                                implicitLayoutAnimationsEnabled: false
                                text: "4.99"
                                onClicked: {
                                    digitalGoodPaymentManager.requestPurchase("", "SKU59946730", "donate4.99");
                                }
                            }
                            CustomButton {
                                preferredWidth: 100
                                implicitLayoutAnimationsEnabled: false
                                text: "9.99"
                                onClicked: {
                                    digitalGoodPaymentManager.requestPurchase("", "SKU59946731", "donate9.99");
                                }
                            }
                        }
                        Container {
                            topPadding: 40
                            horizontalAlignment: HorizontalAlignment.Center
                            CustomButton {
                                preferredWidth: 400
                                implicitLayoutAnimationsEnabled: false
                                text: qsTr("Close")
                                onClicked: {
                                    mDonate.close()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}