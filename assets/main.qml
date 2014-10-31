import bb.cascades 1.2

TabbedPane {
    showTabsOnActionBar: true
    Tab {
        title: qsTr("Buddies")
        Buddies {
        }
    }

    Tab {
        title: qsTr("Recent")
        Recents {
        }
    }
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            onTriggered: {
                settingsPane.createObject().open()
            }
        }
        actions: [
            ActionItem {
                title: qsTr("About")
                imageSource: "asset:///images/ic_info.png"
                onTriggered: {
                    aboutPane.createObject().open()
                }
            }
            /*,
             * ActionItem {
             * title: qsTr("Addresses")
             * onTriggered: {
             * }
             }*/
        ]
    }
    attachedObjects: [
        ComponentDefinition {
            id: aboutPane
            About {
            }
        },
        ComponentDefinition {
            id: settingsPane
            Settings {
            }
        },
        ComponentDefinition {
            id: progressDialog
            ProgressPage {
            }
        },
        ComponentDefinition {
            id: reviewDialog
            ReviewDialog {
            }
        },
        ComponentDefinition {
            id: tempsPane
            TermsPage {
            }
        }
    ]

    onCreationCompleted: {
        _control.transferStart.connect(openProgressDialog)
        if (_control.showTermsOnStart) {
            tempsPane.createObject().open()
        }
        else if(_control.showReviewOnsart){
            reviewDialog.createObject().open()
        }
    }

    function openProgressDialog() {
        progressDialog.createObject().open()
    }
}