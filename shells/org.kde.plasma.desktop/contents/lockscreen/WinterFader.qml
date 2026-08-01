/*
    SPDX-FileCopyrightText: 2014 Aleix Pol Gonzalez <aleixpol@blue-systems.com>
    SPDX-FileCopyrightText: 2026 Mithun A

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick
import QtCore
import Qt5Compat.GraphicalEffects
import QtMultimedia

import org.kde.kirigami as Kirigami

Item {
    id: winterFader
    property Item clock
    property Item mainStack
    property Item footer
    property alias source: wallpaperBlur.source
    property real factor: 0
    readonly property bool lightColorScheme: Math.max(Kirigami.Theme.backgroundColor.r, Kirigami.Theme.backgroundColor.g, Kirigami.Theme.backgroundColor.b) > 0.5

    property bool alwaysShowClock: false
    readonly property string backgroundPath: StandardPaths.locate(
        StandardPaths.GenericDataLocation,
        "plasma/look-and-feel/io.github.fizzy444.winterlock/contents/lockscreen/assets/background.mp4"
    )

    state: "on"

    Behavior on factor {
        NumberAnimation {
            target: winterFader
            property: "factor"
            duration: Kirigami.Units.veryLongDuration * 2
            easing.type: Easing.InOutQuad
        }
    }
    FastBlur {
        id: wallpaperBlur
        anchors.fill: parent
        radius: 50 * winterFader.factor
    }

    // The bundled video lives in the Global Theme package. Keeping one copy
    // there lets this shell override run without an SDDM Winter installation.
    MediaPlayer {
        id: winterScenePlayer
        source: winterFader.backgroundPath
        loops: MediaPlayer.Infinite
        videoOutput: winterScene
        Component.onCompleted: play()
    }
    ShaderEffect {
        id: wallpaperShader
        anchors.fill: parent
        supportsAtlasTextures: true
        property var source: ShaderEffectSource {
            sourceItem: wallpaperBlur
            live: true
            hideSource: true
            textureMirroring: ShaderEffectSource.NoMirroring
        }

        readonly property real contrast: 0.8 * winterFader.factor + (1 - winterFader.factor)
        readonly property real saturation: 1.5 * winterFader.factor + (1 - winterFader.factor)
        readonly property real intensity: (winterFader.lightColorScheme ? 1.6 : 0.7) * winterFader.factor + (1 - winterFader.factor)

        readonly property real transl: (1.0 - contrast) / 2.0;
        readonly property real rval: (1.0 - saturation) * 0.2126;
        readonly property real gval: (1.0 - saturation) * 0.7152;
        readonly property real bval: (1.0 - saturation) * 0.0722;

        property var colorMatrix: Qt.matrix4x4(
            contrast, 0,        0,        0.0,
            0,        contrast, 0,        0.0,
            0,        0,        contrast, 0.0,
            transl,   transl,   transl,   1.0).times(Qt.matrix4x4(
                rval + saturation, rval,     rval,     0.0,
                gval,     gval + saturation, gval,     0.0,
                bval,     bval,     bval + saturation, 0.0,
                0,        0,        0,        1.0)).times(Qt.matrix4x4(
                    intensity, 0,         0,         0,
                    0,         intensity, 0,         0,
                    0,         0,         intensity, 0,
                    0,         0,         0,         1
                ));

        fragmentShader: "qrc:/qt/qml/org/kde/breeze/components/shaders/WallpaperFader.frag.qsb"
    }

    VideoOutput {
        id: winterScene
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "#5c06101d"
    }

    states: [
        State {
            name: "on"
            PropertyChanges {
                mainStack.opacity: 1
                footer.opacity: 1
                winterFader.factor: 1
                clock.shadow.opacity: 0
                clock.opacity: 1
            }
        },
        State {
            name: "off"
            PropertyChanges {
                mainStack.opacity: 0
                footer.opacity: 0
                winterFader.factor: 0
                clock.shadow.opacity: winterFader.alwaysShowClock ? 1 : 0
                clock.opacity: winterFader.alwaysShowClock ? 1 : 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "off"
            to: "on"
            //Note: can't use animators as they don't play well with parallelanimations
            NumberAnimation {
                targets: [winterFader.mainStack, winterFader.footer, winterFader.clock]
                property: "opacity"
                duration: Kirigami.Units.veryLongDuration
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "on"
            to: "off"
            NumberAnimation {
                targets: [winterFader.mainStack, winterFader.footer, winterFader.clock]
                property: "opacity"
                duration: Kirigami.Units.veryLongDuration
                easing.type: Easing.InOutQuad
            }
        }
    ]
}
