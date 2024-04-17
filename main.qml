import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    id: gameField
    width: 480
    height: 640
    visible: true
    title: qsTr("Game started")

    function generateObjects() {
        var obj = btnComp.createObject(gameField)
        generateObjectsTimer.interval = Math.random() * (900) + 100
    }
    function setLooseCase() {
        title = "Game over!"
        color = "pink"
        looseLayout.visible = true
    }

    Component {
        id:btnComp
        Button {
            id:btn
            width: 35
            height: 35
            x: Math.random() * (gameField.width - width)
            y: Math.random() * 100
            text: "*"
            property int verticalShift : Math.random() * 4 + 3
            onClicked: {
                destroy()
            }
            function moveDown() {
                y += verticalShift
                if (y > gameField.height - height) {
                    destroy()
                    gameField.setLooseCase()
                }
            }
            Timer {
                interval: hovered ? 50 : 100
                onTriggered: moveDown()
                running: true
                repeat: true
            }
        }
    }
    ColumnLayout
    {
        id: looseLayout
        anchors.fill: parent
        visible: false
        Text {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignCenter
            font {
                pixelSize: 40
                bold: true
                wordSpacing: 40
            }
            text: "YOU LOOSE"
        }
    }
    Timer {
        id : generateObjectsTimer
        interval: Math.random() * (900) + 100
        onTriggered: generateObjects()
        running: true
        repeat: true
    }
}
