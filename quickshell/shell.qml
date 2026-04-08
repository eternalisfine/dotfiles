import Quickshell
import Quickshell.Io
import QtQuick

ShellRoot {
  PanelWindow {
    id: hotCorner

    anchors {
      bottom: true
      right: true
    }

    width: 40
    height: 40
    color: "transparent"
    aboveWindows: true

    Component.onCompleted:{
      if (this.WlrLayershell != null) {
        this.WlrLayershell.layer = WlrLayer.Overlay
      }
    }

    Rectangle {
      id: glowRect
      anchors.fill: parent
      color: "transparent"
      opacity: 0

      Rectangle {
        width: 80
        height: 80
        x: -40
        y: -40
        radius: 80
        color: "#CBA6F7"
        opacity: glowRect.opacity

        Behavior on opacity {
          NumberAnimation {duration: 350; easing.type: Easing.InOutQuad }
        }
      }

      Behavior on opacity {
        NumberAnimation { duration: 350; easing.type: Easing.InOutQuad }
      }
    }

    Timer {
      id: fadeOutTimer
      interval: 300
      repeat: false
      onTriggered: glowRect.opacity = 0
    }

    MouseArea {
      id: mouse
      anchors.fill: parent
      hoverEnabled: true
      onEntered: {
        fadeOutTimer.stop()
        glowRect.opacity = 0.6
      }
      onExited: {
        console.log("exited")
        glowRect.opacity - 0
      }
      onClicked: {
        glowRect.opacity = 1
        swayncToggle.running = true
        fadeOutTimer.start()
      }
    }

    Process {
      id: swayncToggle
      command: ["swaync-client","-t"]
    }
  }
}
