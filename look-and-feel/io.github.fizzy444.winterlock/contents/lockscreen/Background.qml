+/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick

Item {
    id: bgRoot
    
    Rectangle {
        anchors.fill: parent
        color: "#05080c"
        z: -1000
    }
    
    Wallpaper {
        id: wallpaper
        anchors.fill: parent
        z: -500
    }
    
    // Subtle dark gradient from bottom up to improve text legibility
    Rectangle {
        anchors.fill: parent
        z: -300
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#00000000" }
            GradientStop { position: 0.5; color: "#00000000" }
            GradientStop { position: 1.0; color: Theme.backgroundOverlay }
        }
    }
}
