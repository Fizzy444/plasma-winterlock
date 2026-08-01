import QtQuick
import QtCore

Item {
    id: root
    property Item shadow: null
    implicitWidth: clockColumn.implicitWidth
    implicitHeight: clockColumn.implicitHeight

    FontLoader {
        id: winterFont
        source: StandardPaths.locate(
            StandardPaths.GenericDataLocation,
            "plasma/look-and-feel/io.github.fizzy444.winterlock/contents/lockscreen/assets/fonts/Orbitron-VariableFont_wght.ttf"
        )
    }

    function updateDateTime() {
        const now = new Date();
        timeLabel.text = Qt.formatTime(now, "HH:mm");
        dateLabel.text = Qt.formatDate(now, "dddd, MMMM d").toUpperCase();
    }
    Component.onCompleted: updateDateTime()

    Timer { interval: 1000; running: true; repeat: true; onTriggered: root.updateDateTime() }

    Column {
        id: clockColumn
        anchors.centerIn: parent
        spacing: 7
        Text {
            id: timeLabel
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#e9fbff"
            font.family: winterFont.status === FontLoader.Ready ? winterFont.name : "Noto Sans"
            font.pixelSize: 82
            font.weight: Font.Light
            font.letterSpacing: 5
            style: Text.Raised
            styleColor: "#65081422"
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: Math.max(112, timeLabel.implicitWidth * 0.55)
            height: 1
            color: "#a8eaf8"
            opacity: 0.78
        }
        Text {
            id: dateLabel
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#b8dce6"
            font.family: winterFont.status === FontLoader.Ready ? winterFont.name : "Noto Sans"
            font.pixelSize: 12
            font.weight: Font.DemiBold
            font.letterSpacing: 3
        }
    }
}
