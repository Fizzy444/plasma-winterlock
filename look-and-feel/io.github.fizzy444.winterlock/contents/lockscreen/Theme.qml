pragma Singleton
import QtQuick

QtObject {
    id: theme

    // Colors
    readonly property color textPrimary: "#ffffff"
    readonly property color textSecondary: "#99aab5"
    readonly property color accent: "#cde4ef"
    readonly property color backgroundOverlay: "#aa05080c"
    readonly property color error: "#ff4444"
    
    // Fonts
    readonly property string fontFamily: "Inter, Noto Sans, sans-serif"
    
    // Animation Durations
    readonly property int animFast: 150
    readonly property int animNormal: 250
    readonly property int animSlow: 400
    
    // Snow Settings
    readonly property int snowParticleCount: 150
    readonly property real snowSpeedMin: 20
    readonly property real snowSpeedMax: 70
}
