import QtQuick 2.5
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4 as Qqc
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtMultimedia 5.5
import SddmComponents 2.0

Rectangle {
	color: "black"
	width: Window.width
	height: Window.height

	Connections {
		target: sddm

		onLoginSucceeded: {
		}

		onLoginFailed: {
			denied.play()
		}
	}

	AnimatedImage {
		width: parent.width
		height: parent.height
		fillMode: Image.Tile
		source: "bgN5.gif"
	}

	ColumnLayout {
		width: parent.width
		height: parent.height
		AnimatedImage{
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 2
			width: 192
			height: 192
			source: "WiredLogIn.gif"
		}
		AnimatedImage{
			Layout.alignment: Qt.AlignCenter
			Layout.bottomMargin: 20
			height: 50
			source: "whoIsUser.gif"
		}
		Qqc.Label {
			Layout.alignment: Qt.AlignCenter
			text: "Ｕｓｅｒ ＩD:"
			color: "#c1b492"
			font.pixelSize: 16
		}
		Qqc.TextField {
			id: username
			Layout.alignment: Qt.AlignCenter
			text: userModel.lastUser
			style: TextFieldStyle {
				textColor: "#c1b492"
				background: Rectangle {
					color: "#000"
					implicitWidth: 200
					border.color: "#d2738a"
				}
			}
			KeyNavigation.backtab: shutdownBtn; KeyNavigation.tab: password
			Keys.onPressed: {
				if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
					sddm.login(username.text, password.text, session.index)
					event.accepted = true
				}
			}
		}
		Qqc.Label {
			Layout.alignment: Qt.AlignCenter
			text: "Ｐａｓｓｗｏｒｄ："
			color: "#c1b492"
			font.pixelSize: 16
		}
		Qqc.TextField {
			id: password
			echoMode: TextInput.Password
			Layout.alignment: Qt.AlignCenter
			style: TextFieldStyle {
				textColor: "#c1b492"
				background: Rectangle {
					color: "#000"
					implicitWidth: 200
					border.color: "#d2738a"
				}
			}
			KeyNavigation.backtab: username; KeyNavigation.tab: session
			Keys.onPressed: {
				if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
					sddm.login(username.text, password.text, session.index)
					event.accepted = true
				}
			}
		}
		ColumnLayout {
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 4
			Layout.bottomMargin: 50
			width: 200
			Rectangle {
				anchors.fill: parent
				color: "#d2738a"
			}
			Qqc.Label {
				Layout.alignment: Qt.AlignCenter
				text: "Ｌｏｇｉｎ"
				color: "#c1b492"
				font.pixelSize: 20
			}
			MouseArea {
				anchors.fill: parent
				onClicked: sddm.login(username.text, password.text, session.index)
			}
		}
	}
	AnimatedImage {
		id: shutdownBtn
		height: 80
		width: 80
		y: 10
		x: Window.width - width - 10
		source: "VisLain.gif"
		fillMode: Image.PreserveAspectFit
		MouseArea {
			anchors.fill: parent
			onClicked: sddm.powerOff()
		}
	}
	AnimatedImage {
		id: rebootBtn
		anchors.right: shutdownBtn.left
		anchors.rightMargin: 5
		y: shutdownBtn.y + 10
		height: 70
		width: 60
		source: "lain_myese.gif"
		fillMode: Image.PreserveAspectFit
		MouseArea {
			anchors.fill: parent
			onClicked: sddm.reboot()
		}
	}
	ComboBox {
		id: session
		height: 30
		width: 200
		x: 15
		y: 20
		// arrowIcon: "angle-down.png"
		model: sessionModel
		index: sessionModel.lastIndex
		color: "#000"
		borderColor: "#d2738a"
		focusColor: "#d2738a"
		hoverColor: "#d2738a"
		textColor: "#c1b492"
		arrowIcon: "angle-down.png"
		// style: ComboBoxStyle {
		// 	selectedTextColor: "#000"
		// 	selectionColor: "#d2738a"
		// 	background: Rectangle {
		// 	}
		// }
		KeyNavigation.backtab: password; KeyNavigation.tab: rebootBtn;
	}
	Audio {
		id: bgMusic
		source: "bg_music.wav"
		autoPlay: true
		loops: Audio.Infinite
	}
	Audio {
		id: welcome
		source: "welcome.wav"
		autoPlay: true
	}
	Audio {
		id: denied
		source: "denied.wav"
	}

	Component.onCompleted: {
		if (username.text == "") {
			username.focus = true
		} else {
			password.focus = true
		}
	}
}

