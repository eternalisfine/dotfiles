import QtQuick 2.15
import QtMultimedia 5.15
import SddmComponents 2.0

Rectangle {
    width: 1920
    height: 1080
    color: "#000000"

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

    Item {
        id: overlay
        anchors.fill: parent

        TextConstants { id: textConstants }

        Connections {
            target: sddm
            onLoginSucceeded: {
                statusText.text  = ""
                statusText.color = "#ff007f"
            }
            onLoginFailed: {
                statusText.text  = textConstants.loginFailed
                statusText.color = "#ff4444"
                shakeAnimation.restart()
                passwordField.text = ""
                passwordField.forceActiveFocus()
            }
        }

        Column {
            id: clockBlock
            anchors {
                left:   parent.left
                bottom: parent.bottom
                margins: 52
            }
            spacing: 4

            Text {
                id: timeLabel
                font.pixelSize:  112
                font.weight:     Font.Thin
                font.letterSpacing: -4
                color: "#ff007f"
                style: Text.Raised
                styleColor: Qt.rgba(1, 0, 0.498, 0.35)

                Timer {
                    interval: 1000
                    running:  true
                    repeat:   true
                    triggeredOnStart: true
                    onTriggered: {
                        var now = new Date()
                        var h   = now.getHours()
                        var m   = now.getMinutes()
                        timeLabel.text = (h < 10 ? "0" : "") + h + ":" + (m < 10 ? "0" : "") + m
                    }
                }
            }

            Text {
                id: dateLabel
                font.pixelSize: 22
                font.weight:    Font.Light
                font.letterSpacing: 1.5
                color: Qt.rgba(1, 1, 1, 0.55)

                Timer {
                    interval: 60000
                    running:  true
                    repeat:   true
                    triggeredOnStart: true
                    onTriggered: {
                        var now  = new Date()
                        var days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
                        var months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
                        dateLabel.text = days[now.getDay()] + ", " + months[now.getMonth()] + " " + now.getDate()
                    }
                }
            }
        }

        Column {
            id: loginBlock
            anchors.centerIn: parent
            spacing: 14
            width: 340

            Text {
                id: usernameLabel
                text:  userModel.lastUser
                color: Qt.rgba(1, 1, 1, 0.30)
                font.pixelSize:  13
                font.letterSpacing: 2.5
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Item {
                id: pillWrapper
                width:  parent.width
                height: 48

                SequentialAnimation {
                    id: shakeAnimation
                    loops: 1
                    PropertyAnimation { target: pillWrapper; property: "x"; to:  10; duration: 40; easing.type: Easing.InOutQuad }
                    PropertyAnimation { target: pillWrapper; property: "x"; to: -10; duration: 40; easing.type: Easing.InOutQuad }
                    PropertyAnimation { target: pillWrapper; property: "x"; to:   8; duration: 40; easing.type: Easing.InOutQuad }
                    PropertyAnimation { target: pillWrapper; property: "x"; to:  -8; duration: 40; easing.type: Easing.InOutQuad }
                    PropertyAnimation { target: pillWrapper; property: "x"; to:   4; duration: 35; easing.type: Easing.InOutQuad }
                    PropertyAnimation { target: pillWrapper; property: "x"; to:  -4; duration: 35; easing.type: Easing.InOutQuad }
                    PropertyAnimation { target: pillWrapper; property: "x"; to:   0; duration: 30; easing.type: Easing.OutQuad }
                }

                Rectangle {
                    anchors.fill: parent
                    radius:       24
                    color:        Qt.rgba(1, 1, 1, 0.04)
                    border.color: passwordField.activeFocus ? Qt.rgba(1, 0, 0.498, 0.55) : Qt.rgba(1, 1, 1, 0.10)
                    border.width: 1
                    Behavior on border.color { ColorAnimation { duration: 200 } }
                }

                Rectangle {
                    id: accentLine
                    anchors {
                        bottom: parent.bottom
                        left:   parent.left
                        right:  parent.right
                        leftMargin:  12
                        rightMargin: 12
                    }
                    height: 2
                    radius: 1
                    color:  passwordField.activeFocus ? "#ff007f" : "transparent"
                    Behavior on color { ColorAnimation { duration: 220 } }

                    Rectangle {
                        anchors.centerIn: parent
                        width:  parent.width
                        height: 8
                        radius: 4
                        color:  Qt.rgba(1, 0, 0.498, passwordField.activeFocus ? 0.25 : 0)
                        Behavior on color { ColorAnimation { duration: 220 } }
                    }
                }

                Text {
                    id: lockIcon
                    anchors {
                        left:           parent.left
                        leftMargin:     16
                        verticalCenter: parent.verticalCenter
                    }
                    text:  "🔒"
                    font.pixelSize: 15
                    opacity: 0.45
                }

                TextInput {
                    id: passwordField
                    anchors {
                        left:           lockIcon.right
                        leftMargin:     10
                        right:          parent.right
                        rightMargin:    16
                        verticalCenter: parent.verticalCenter
                    }
                    echoMode:           TextInput.Password
                    passwordCharacter:  "•"
                    color:              "#ffffff"
                    font.pixelSize:     16
                    font.letterSpacing: 1
                    selectionColor:     Qt.rgba(1, 0, 0.498, 0.45)
                    clip:               true

                    Text {
                        anchors.fill: parent
                        text:         textConstants.password
                        color:        Qt.rgba(1, 1, 1, 0.25)
                        font:         passwordField.font
                        visible:      passwordField.text.length === 0 && !passwordField.activeFocus
                    }

                    Keys.onReturnPressed: {
                        statusText.text = ""
                        sddm.login(userModel.lastUser, passwordField.text, sessionModel.lastIndex)
                    }
                }
            }

            Text {
                id: statusText
                anchors.horizontalCenter: parent.horizontalCenter
                text:  ""
                color: "#ff4444"
                font.pixelSize:  12
                font.letterSpacing: 1
            }
        }
    }

    Component.onCompleted: passwordField.forceActiveFocus()
}
