+/*
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import Qt.labs.folderlistmodel

Item {
    id: mainRoot
    
    // Global scaling factor
    readonly property real s: width / 1920

    // Font loading
    FolderListModel { 
        id: fontFolder
        folder: Qt.resolvedUrl("assets/fonts")
        nameFilters: ["*.ttf", "*.otf"] 
    }
    
    FontLoader { 
        id: mainFont
        source: fontFolder.count > 0 ? "assets/fonts/" + fontFolder.get(0, "fileName") : "" 
    }
    
    property string activeFontFamily: mainFont.status === FontLoader.Ready ? mainFont.name : Theme.fontFamily

    Background {
        anchors.fill: parent
    }
    
    Snow {
        anchors.fill: parent
    }
    
    // Top Center: Time and Date
    Column {
        anchors.top: parent.top
        anchors.topMargin: 120 * s
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15 * s
        
        Clock { }
        WinterDate { }
    }
    
    // Center: User Area
    User {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 160 * s // Pushed down beautifully into the treeline
    }
}
