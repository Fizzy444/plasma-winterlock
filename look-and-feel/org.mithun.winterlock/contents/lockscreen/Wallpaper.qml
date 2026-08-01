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
