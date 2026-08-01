+/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import org.kde.plasma.core as PlasmaCore

Item {
    id: userRoot
    width: 400 * s
    height: 120 * s
    
    property string username: typeof kscreenlocker_userName !== "undefined" ? kscreenlocker_userName : "USER"
    
    Column {
        anchors.centerIn: parent
        spacing: 25 * s
        width: parent.width
        
        // User Label
        Item {
            width: parent.width
            height: 30 * s
            
            Column {
                anchors.centerIn: parent
                spacing: 2 * s
                
                Text { 
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "USER"
                    font.family: activeFontFamily
                    font.pixelSize: 10 * s
                    font.letterSpacing: 4 * s
                    color: Theme.textSecondary
                    opacity: 0.8 
                }
                
                Text {
                    id: userNameText
                    text: userRoot.username.toUpperCase()
                    font.family: activeFontFamily
                    font.pixelSize: 18 * s
                    font.letterSpacing: 3 * s
                    font.weight: Font.Bold
                    color: Theme.textPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
        
        // Password Field
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 320 * s
            height: 50 * s
            
            PasswordField {
                id: passField
                anchors.fill: parent
                onAccepted: {
                    userRoot.tryUnlock(passField.text);
                }
            }
        }
    }
    
    // Login functionality
    function tryUnlock(password) {
        if (typeof authenticator !== "undefined") {
            authenticator.tryUnlock(password);
        } else {
            console.log("Unlock requested with password:", password);
            loginFailed();
        }
    }
    
    Connections {
        target: typeof authenticator !== "undefined" ? authenticator : null
        ignoreUnknownSignals: true
        function onFailed() {
            loginFailed();
        }
        function onSucceeded() {
            // Unlock successful
        }
    }
    
    function loginFailed() {
        passField.notifyError();
    }
    
    Connections {
        target: root // root is LockScreen.qml
        ignoreUnknownSignals: true
        function onClearPassword() {
            passField.clear();
        }
    }
}
