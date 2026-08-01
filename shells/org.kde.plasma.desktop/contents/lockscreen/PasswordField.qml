+/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick

Item {
    id: passRoot
    property alias text: passInput.text
    signal accepted()
    
    TextInput {
        id: passInput
        anchors.fill: parent
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        echoMode: TextInput.Password
        passwordCharacter: "·"
        font.family: activeFontFamily
        font.pixelSize: 32 * s
        font.letterSpacing: 10 * s
        color: Theme.textPrimary
        clip: true
        focus: true
        cursorVisible: false
        selectionColor: Theme.accent
        
        property bool wasClicked: false
        onActiveFocusChanged: if (!activeFocus && text.length === 0) wasClicked = false
        
        onAccepted: passRoot.accepted()
        
        Text {
            anchors.centerIn: parent
            text: "PASSWORD"
            font.family: activeFontFamily
            font.pixelSize: 14 * s
            font.letterSpacing: 6 * s
            color: Theme.textSecondary
            opacity: passInput.text.length === 0 ? 0.6 : 0.0
            Behavior on opacity { NumberAnimation { duration: Theme.animSlow; easing.type: Easing.InOutSine } }
        }
        
        Rectangle {
            id: customCursor
            width: 2.2 * s
            height: 32 * s
            color: Theme.textPrimary
            anchors.verticalCenter: parent.verticalCenter
            x: passInput.cursorRectangle.x - (width / 2)
            visible: passInput.focus && (passInput.text.length > 0 || passInput.wasClicked)
            
            SequentialAnimation {
                loops: Animation.Infinite
                running: customCursor.visible
                NumberAnimation { target: customCursor; property: "opacity"; from: 1; to: 0.05; duration: 450 }
                NumberAnimation { target: customCursor; property: "opacity"; from: 0.05; to: 1; duration: 450 }
            }
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                passInput.forceActiveFocus();
                passInput.wasClicked = true;
            }
        }
        
        SequentialAnimation {
            id: errorShake
            NumberAnimation { target: passInput; property: "x"; to: -10 * s; duration: 50 }
            NumberAnimation { target: passInput; property: "x"; to:  10 * s; duration: 50 }
            NumberAnimation { target: passInput; property: "x"; to: -10 * s; duration: 50 }
            NumberAnimation { target: passInput; property: "x"; to:  10 * s; duration: 50 }
            NumberAnimation { target: passInput; property: "x"; to:  0;      duration: 50 }
        }
    }
    
    property bool loginError: false
    
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        height: 1
        width: passInput.activeFocus ? parent.width : parent.width * 0.3
        color: passRoot.loginError ? Theme.error : Theme.textPrimary
        opacity: passInput.activeFocus ? 0.8 : 0.2
        Behavior on width { NumberAnimation { duration: 350; easing.type: Easing.OutQuart } }
        Behavior on opacity { NumberAnimation { duration: 350 } }
        Behavior on color { ColorAnimation { duration: Theme.animNormal } }
    }
    
    function notifyError() {
        passRoot.loginError = true;
        passInput.text = "";
        errorShake.start();
        passInput.forceActiveFocus();
        errorResetTimer.start();
    }
    
    Timer {
        id: errorResetTimer
        interval: 2000
        onTriggered: passRoot.loginError = false
    }
    
    function clear() {
        passInput.text = "";
        passRoot.loginError = false;
        passInput.forceActiveFocus();
    }
}
