/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import "components"

Item {
    id: snowRoot
    anchors.fill: parent
    
    Repeater {
        model: Theme.snowParticleCount
        
        FloatingParticle {
            minX: 0
            maxX: snowRoot.width
            minY: 0
            maxY: snowRoot.height
            
            Component.onCompleted: {
                x = Math.random() * snowRoot.width;
                y = Math.random() * snowRoot.height;
                init();
            }
        }
    }
}
