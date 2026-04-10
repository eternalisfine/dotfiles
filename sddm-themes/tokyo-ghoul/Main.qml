import QtQuick 2.15
import QtMultimedia 5.15
import SddmComponents 2.0

Rectangle {
    width: 1920
    height: 1080
    color: "#000000"

    // This block plays your background video
    MediaPlayer {
        id: myVideo
        source: Qt.resolvedUrl("video/kaneki-ken.3840x2160.mp4")
        autoPlay: true
        loops: MediaPlayer.Infinite
    }

    VideoOutput {
        anchors.fill: parent
        source: myVideo
        fillMode: VideoOutput.PreserveAspectCrop
    }

    // This block creates the AMOLED login box
    Rectangle {
        anchors.centerIn: parent
        width: 350
        height: 250
        color: "#000000"
        border.color: "#ff007f" // Pinkish-red accent border
        border.width: 2
        radius: 12
        opacity: 0.90

        Column {
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: "Welcome"
                color: "#ffffff"
                font.pixelSize: 24
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextBox {
                id: userEntry
                width: 250
                text: userModel.lastUser
                font.pixelSize: 16
            }

            PasswordBox {
                id: passEntry
                width: 250
                font.pixelSize: 16
                focus: true
                Keys.onPressed: {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(userEntry.text, passEntry.text, sessionModel.lastIndex)
                    }
                }
            }
        }
    }
}
