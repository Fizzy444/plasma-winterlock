/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import "components"

Item {
    id: dateRoot
    width: dateText.width
    height: dateText.height
    
    Text {
        id: dateText
        anchors.centerIn: parent
        text: Qt.formatDate(new Date(), "dddd, MMMM d").toUpperCase()
        font.family: activeFontFamily
        font.pixelSize: 18 * s
        font.letterSpacing: 12 * s
        font.weight: Font.DemiBold
        color: "#1a252c"
        opacity: 0.85
        
        Timer {
            interval: 60000
            running: true
            repeat: true
            onTriggered: dateText.text = Qt.formatDate(new Date(), "dddd, MMMM d").toUpperCase()
        }
    }
    
    Shadow {
        anchors.fill: dateText
        source: dateText
        radius: 12 * s
        color: "#55ffffff"
        verticalOffset: 0
    }
}
