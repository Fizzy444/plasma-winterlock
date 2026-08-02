/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import ".." as Winter

Item {
    id: particle
    width: size
    height: size
    
    property real size: 2 + Math.random() * 4
    property real minX: 0
    property real maxX: 1920
    property real minY: 0
    property real maxY: 1080
    
    property real speedY: Winter.Theme.snowSpeedMin + Math.random() * (Winter.Theme.snowSpeedMax - Winter.Theme.snowSpeedMin)
    property real windX: (Math.random() - 0.5) * 20
    
    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "#ffffff"
        opacity: 0.2 + Math.random() * 0.6
    }
    
    NumberAnimation on y {
        id: animY
        from: particle.minY - particle.size
        to: particle.maxY + particle.size
        duration: ((particle.maxY + particle.size) - (particle.minY - particle.size)) / particle.speedY * 1000
        loops: Animation.Infinite
        running: false
        
        onStopped: {
            if (particle.visible) {
                particle.x = particle.minX + Math.random() * (particle.maxX - particle.minX);
                particle.speedY = Winter.Theme.snowSpeedMin + Math.random() * (Winter.Theme.snowSpeedMax - Winter.Theme.snowSpeedMin);
                animY.duration = ((particle.maxY + particle.size) - (particle.minY - particle.size)) / particle.speedY * 1000;
                animY.start();
            }
        }
    }
    
    NumberAnimation on x {
        id: animX
        from: particle.x
        to: particle.x + particle.windX * 100
        duration: animY.duration
        loops: Animation.Infinite
        running: false
    }

    function init() {
        animY.start();
        animX.start();
    }
}
