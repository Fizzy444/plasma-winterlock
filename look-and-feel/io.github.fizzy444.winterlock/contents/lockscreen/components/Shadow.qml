+/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import QtQuick.Effects

Item {
    id: shadowRoot
    property variant source: null
    property real radius: 25
    property color color: "#50000000"
    property real verticalOffset: 6
    
    MultiEffect {
        anchors.fill: parent
        source: shadowRoot.source
        autoPaddingEnabled: true
        shadowEnabled: true
        shadowBlur: shadowRoot.radius / 64.0
        shadowColor: shadowRoot.color
        shadowVerticalOffset: shadowRoot.verticalOffset
        shadowHorizontalOffset: 0
    }
}
