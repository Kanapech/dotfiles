import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick.Layouts

ShellRoot {
    Scope {
        id: root

        PanelWindow {
            id: panel
            visible: true

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            WlrLayershell.namespace: "rice-switcher"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: panel.visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

            color: "transparent"

            Rectangle {
                id: content
                anchors.fill: parent
                color: "#cc000000"
                focus: true

                property var rices: []
                property string activeRice: ""
                property int selectedIndex: 0

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 20

                    Text {
                        text: "Switch Rice"
                        font.pointSize: 24
                        font.bold: true
                        color: "#ffffff"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Text {
                        text: content.activeRice ? "Current: " + content.activeRice : "Current: unknown"
                        font.pointSize: 12
                        color: "#aaaaaa"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    RowLayout {
                        spacing: 16
                        Layout.alignment: Qt.AlignHCenter

                        Repeater {
                            model: content.rices

                            Rectangle {
                                id: card

                                required property int index
                                required property var modelData

                                width: 180
                                height: 120
                                radius: 12
                                color: {
                                    if (index === content.selectedIndex) return "#3d5a80"
                                    if (modelData.name === content.activeRice) return "#2a4a3a"
                                    return "#1e1e2e"
                                }
                                border.width: index === content.selectedIndex ? 2 : 0
                                border.color: "#89b4fa"

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: content.selectedIndex = index
                                    onClicked: content.switchToRice(modelData.name)
                                }

                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 8

                                    Text {
                                        text: "🍚"
                                        font.pointSize: 28
                                        Layout.alignment: Qt.AlignHCenter
                                    }

                                    Text {
                                        text: modelData.name
                                        font.pointSize: 14
                                        font.bold: true
                                        color: "#ffffff"
                                        Layout.alignment: Qt.AlignHCenter
                                    }

                                    Text {
                                        text: modelData.name === content.activeRice ? "● Active" : ""
                                        font.pointSize: 10
                                        color: "#a6e3a1"
                                        Layout.alignment: Qt.AlignHCenter
                                    }
                                }
                            }
                        }
                    }

                    Text {
                        text: "← → Navigate · Enter Select · Esc Close"
                        font.pointSize: 10
                        color: "#666666"
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Left) {
                        event.accepted = true
                        if (content.selectedIndex > 0) content.selectedIndex--
                        else content.selectedIndex = content.rices.length - 1
                    } else if (event.key === Qt.Key_Right) {
                        event.accepted = true
                        if (content.selectedIndex < content.rices.length - 1) content.selectedIndex++
                        else content.selectedIndex = 0
                    } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        event.accepted = true
                        if (content.rices.length > 0) content.switchToRice(content.rices[content.selectedIndex].name)
                    } else if (event.key === Qt.Key_Escape) {
                        event.accepted = true
                        Qt.quit()
                    }
                }

                function switchToRice(riceName) {
                    if (riceName !== content.activeRice) {
                        switchProcess.command = ["fish", "-c", "switch-rice " + riceName]
                        switchProcess.running = true
                    }
                    Qt.quit()
                }

                Process {
                    id: switchProcess
                }

                Process {
                    id: readRicesProc
                    property var ricesList: []
                    command: ["cat", "/home/joran/.local/share/chezmoi/.rices"]
                    running: true
                    stdout: SplitParser {
                        onRead: (data) => {
                            var line = data.trim()
                            if (line) {
                                var parts = line.split(":")
                                readRicesProc.ricesList.push({ name: parts[0].trim(), path: parts[1] ? parts[1].trim() : "" })
                            }
                        }
                    }
                    onExited: (exitCode, exitStatus) => {
                        content.rices = readRicesProc.ricesList
                    }
                }

                Process {
                    id: readActiveProc
                    property string buffer: ""
                    command: ["fish", "-c", "grep qsConfig ~/.local/share/chezmoi/.chezmoidata.toml | cut -d'=' -f2 | tr -d ' \"'"]
                    running: true
                    stdout: SplitParser {
                        onRead: (data) => {
                            readActiveProc.buffer += data
                        }
                    }
                    onExited: (exitCode, exitStatus) => {
                        content.activeRice = readActiveProc.buffer.trim()
                    }
                }

                Component.onCompleted: {
                    content.forceActiveFocus()
                }
            }
        }
    }
}
