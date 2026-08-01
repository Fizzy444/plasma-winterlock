+/*
 * SPDX-FileCopyrightText: 2014 Aleix Pol Gonzalez <aleixpol@blue-systems.com>
 * SPDX-FileCopyrightText: 2026 Mithun A
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick

Item {
    id: root

    property bool debug: false
    property string notification
    property bool viewVisible: false
    signal clearPassword()
    signal notificationRepeated()

    LayoutMirroring.enabled: Application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    implicitWidth: 800
    implicitHeight: 600

    LockScreenUi {
        anchors.fill: parent
    }
}
