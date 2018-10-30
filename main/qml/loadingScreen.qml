import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Item {
    id: loadingScreen
    anchors.fill: parent

    Rectangle {
        id: loadingBackground
        width:  parent.width
        height: parent.height
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        ProgressBar {
            id: pBar

            value: 0

            height: 30
            width: parent.width * 0.8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60
            anchors.horizontalCenter: parent.horizontalCenter

            style: ProgressBarStyle {
                background: Rectangle {
                    radius: 2
                    color: "dimgray"
                    border.color: "gray"
                    border.width: 1
                    implicitWidth: 200
                    implicitHeight: 24

                    gradient: Gradient {
                        GradientStop { position: 1.0; color: "black" }
                        GradientStop { position: 0.0; color: "#3B3B3B" }
                    }


                }
                progress: Rectangle {
                    color: "goldenrod"
                    radius: 2
                    //border.color: "steelblue"
                }
            }

            NumberAnimation {
                loops: 1
                running: true
                target: pBar
                property: "value"
                easing.type: Easing.OutInSine
                from: 0
                to: 1
                duration: 10000
            }
        }
    }

    Image {
        id: logo
        width: 600
        height: 340
        source: "../images/logo.png"
        //fillMode: Image.TileVertically
        verticalAlignment: Image.AlignTop
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
