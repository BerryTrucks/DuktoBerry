import bb.cascades 1.2

TabbedPane {
    showTabsOnActionBar: true
    Tab {
        title: "Buddies"
        Buddies {
        }
    }

    Tab {
        title: "Recent"
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
                onTriggered: {
                }
            },
            ActionItem {
                title: qsTr("Addresses")
                onTriggered: {
                }
            }
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
        }
    ]
}