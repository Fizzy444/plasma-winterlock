+/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import QtQuick.Controls

Item {
    id: wallpaperRoot
    
    Image {
        id: img
        anchors.fill: parent
        source: "assets/images/fallback.png"
        fillMode: Image.PreserveAspectCrop
        visible: false // Hidden because Blur handles rendering if active
    }
    
    Blur {
        anchors.fill: parent
        source: img
    }
}
