import bb.cascades 1.2

Sheet {
    id: termsSheet
    Page {
        titleBar: TitleBar {
            kind: TitleBarKind.FreeForm
            kindProperties: CustomFreeFormTitleBar {
                title: qsTr("Disclaimer")
                closeButtonActive: false
            }
        }
        ScrollView {
            Container {
                topPadding: 20
                leftPadding: 20
                rightPadding: 20
                Label {
                    text: "The Software is provided on an AS IS basis, without warranty of any kind, including without limitation the warranties of merchantability, fitness for a particular purpose and non-infringement. The entire risk as to the quality and performance of the Software is borne by you. Should the Software prove defective, you and not the author assume the entire cost of any service and repair.\n\nTHE AUTHOR IS NOT RESPONSIBLE FOR ANY INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES OF ANY CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF GOODWILL, WORK STOPPAGE, COMPUTER FAILURE OR MALFUNCTION, OR ANY AND ALL OTHER COMMERCIAL DAMAGES OR LOSSES.\n\nTitle, ownership rights and intellectual property rights in and to the Software shall remain to the author.\n\n"
                    textStyle.textAlign: TextAlign.Justify
                    multiline: true
                }
                CustomButton {
                    horizontalAlignment: HorizontalAlignment.Right
                    preferredWidth: 350
                    text: "Accept"
                    background: Color.Green
                    onClicked: {
                        _control.showTermsOnStart = false
                        termsSheet.close()
                    }

                }
            }
        }
    }
}