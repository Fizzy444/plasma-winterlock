/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import "components"

Item {
    id: clockRoot
    width: clockText.width
    height: clockText.height
    
    Text {
        id: clockText
        anchors.centerIn: parent
        text: Qt.formatTime(new Date(), "HH:mm")
        font.family: activeFontFamily
        font.pixelSize: 180 * s
        font.weight: Font.Thin
        color: Theme.textPrimary
        style: Text.Normal
        
        Timer { 
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                let newTime = Qt.formatTime(new Date(), "HH:mm");
                if (clockText.text !== newTime) {
                    clockText.text = newTime;
                }
            }
        }
        
        Behavior on text {
            SequentialAnimation {
                NumberAnimation { target: clockText; property: "opacity"; to: 0; duration: Theme.animFast }
                PropertyAction { target: clockText; property: "text" }
                NumberAnimation { target: clockText; property: "opacity"; to: 1; duration: Theme.animFast }
            }
        }
    }
    
    Shadow {
        anchors.fill: clockText
        source: clockText
        radius: 25 * s
        color: "#50000000"
        verticalOffset: 6 * s
    }
}
