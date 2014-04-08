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
            id: m_about
            source: "asset:///About.qml"
        },
        ComponentDefinition {
            id: m_settings
            source: "asset:///Settings.qml"
        }
    ]
}