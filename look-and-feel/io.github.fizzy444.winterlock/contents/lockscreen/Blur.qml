/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import QtQuick.Effects

Item {
    id: blurRoot
    property variant source: null
    property real radius: 30
    property real saturation: 1.2
    
    MultiEffect {
        anchors.fill: parent
        source: blurRoot.source
        autoPaddingEnabled: true
        blurEnabled: true
        blurMax: 64
        blur: blurRoot.radius / 64.0
        saturation: blurRoot.saturation
    }
}
