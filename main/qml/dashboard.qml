import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
//import QtCharts 2.2


//import "MainDash.qml" as mainDashModule



ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 480

    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width

    flags: Qt.FramelessWindowHint
    visibility: Window.FullScreen

    color: "#161616"
    title: "boi"

    ValueSource {
        id: valueSource
    }



    Item{
        id: container
        objectName: 'containerObj'
        visible: false
        width: 800
        height: 480
        anchors.fill: parent

        Image {
            id: background
            width: 800
            height: 480
            source: "../images/Background.png"
            fillMode: Image.TileVertically
            verticalAlignment: Image.AlignTop
        }


        Rectangle {
            id: infoBar
            width:  parent.width
            height: 25
            color: "#2E2E2E"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.top

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                text: "10:30 a.m."
                color: "white"
                font.pixelSize: 18
                font.bold: true
            }
        }

        Rectangle {
            id: currentTimeBar
            width:  parent.width * 0.45
            height: 100
            color: "#2E2E2E"
            anchors.right: parent.left
            y: 40

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#4D4D4D" }
                GradientStop { position: 0.5; color: "#2E2E2E" }
                GradientStop { position: 1.0; color: "#2E2E2E" }
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 3
                text: "Current"
                color: "white"
                font.pixelSize: 20
                font.bold: true
            }

            Text {
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30
//                anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                text: valueSource.currTime
                color: "white"
                font.pixelSize: 60
                font.bold: true
            }
        }

        Rectangle {
            id: fastestTimeBar
            width:  parent.width * 0.45
            height: 100
            color: "#2E2E2E"
            anchors.left: parent.right
            y: 40

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#4D4D4D" }
                GradientStop { position: 0.5; color: "#2E2E2E" }
                GradientStop { position: 1.0; color: "#2E2E2E" }
            }
            Text {
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 3
                text: "Fastest"
                color: "white"
                font.pixelSize: 20
                font.bold: true
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: 10
                //anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                text: "00:00.00"
                color: "white"
                font.pixelSize: 60
                font.bold: true
            }
        }

        Rectangle {
            id: lapBar
            width:  parent.width * 0.2
            height: 85
            color: "#2E2E2E"
            anchors.left: parent.right
            y: 160

            gradient: Gradient {
                GradientStop { position: 0.0; color: "#4D4D4D" }
                GradientStop { position: 0.5; color: "#2E2E2E" }
                GradientStop { position: 1.0; color: "#2E2E2E" }
            }
            Text {
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 3
                text: "Lap"
                color: "white"
                font.pixelSize: 25
                font.bold: true
            }
            Text {
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.right: parent.right
                anchors.rightMargin: 80
                anchors.verticalCenter: parent.verticalCenter
                //anchors.top: parent.top
                //anchors.topMargin: 0
                text: "0"
                color: "white"
                font.pixelSize: 90
                font.bold: true
            }
        }

        CircularGauge {
            visible: true
            id: speedometer
            value: valueSource.mph
            //anchors.verticalCenter: parent.verticalCenter
            maximumValue: 40
            width: height
            height: container.height * 0.8
            y: 500
            x: 300
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.bottom: parent.bottom - 50
            //anchors.top: parent.bottom

            style: CircularGaugeStyle {
                minimumValueAngle: -110
                maximumValueAngle: 110
                tickmarkInset: toPixels(0.04)
                minorTickmarkInset: tickmarkInset
                labelStepSize: 10
                labelInset: toPixels(1.23)

                property real xCenter: outerRadius
                property real yCenter: outerRadius
                property real needleLength: outerRadius - tickmarkInset * 1.25
                property real needleTipWidth: toPixels(0.06)
                property real needleBaseWidth: toPixels(0.06)
                property bool halfGauge: true

                function toPixels(percentage) {
                    return percentage * outerRadius;
                }

                function degToRad(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function radToDeg(radians) {
                    return radians * (180 / Math.PI);
                }

                function paintBackground(ctx) {
                    if (halfGauge) {
                        ctx.beginPath();
                        ctx.rect(0, 0, ctx.canvas.width, ctx.canvas.height * 0.7);
                        ctx.clip();
                    }

                    ctx.beginPath();
                    ctx.fillStyle = "black";
                    ctx.ellipse(0, 0, ctx.canvas.width, ctx.canvas.height);
                    ctx.fill();

                    ctx.beginPath();
                    ctx.lineWidth = tickmarkInset;
                    ctx.strokeStyle = "black";
                    ctx.arc(xCenter, yCenter, outerRadius - ctx.lineWidth / 2, outerRadius - ctx.lineWidth / 2, 0, Math.PI * 2);
                    ctx.stroke();

                    ctx.beginPath();
                    ctx.lineWidth = tickmarkInset / 2;
                    ctx.strokeStyle = "yellow";
                    ctx.arc(xCenter, yCenter, outerRadius - ctx.lineWidth / 2, outerRadius - ctx.lineWidth / 2, 0, Math.PI * 2);
                    ctx.stroke();

                    ctx.beginPath();
                    var gradient = ctx.createRadialGradient(xCenter, yCenter, 0, xCenter, yCenter, outerRadius * 1.5);
                    gradient.addColorStop(0, Qt.rgba(1, 1, 1, 0));
                    gradient.addColorStop(0.7, Qt.rgba(1, 1, 1, 0.13));
                    gradient.addColorStop(1, Qt.rgba(1, 1, 1, 1));
                    ctx.fillStyle = gradient;
                    ctx.arc(xCenter, yCenter, outerRadius - tickmarkInset, outerRadius - tickmarkInset, 0, Math.PI * 2);
                    ctx.fill();
                }

                background: Canvas {
                    id: backGauge
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        paintBackground(ctx);
                    }

            //        Text {
            //            id: speedText
            //            font.pixelSize: toPixels(0.5)
            //            text: kphInt
            //            color: "white"
            //            horizontalAlignment: Text.AlignRight
            //            anchors.horizontalCenter: parent.horizontalCenter
            //            anchors.top: parent.verticalCenter
            //            anchors.topMargin: toPixels(0.1)

            //            readonly property int kphInt: control.value
            //        }
            //        Text {
            //            text: "km/h"
            //            color: "white"
            //            font.pixelSize: toPixels(0.09)
            //            anchors.top: speedText.bottom
            //            anchors.horizontalCenter: parent.horizontalCenter
            //        }
                }

                needle: Canvas {
                    implicitWidth: needleBaseWidth
                    implicitHeight: needleLength

                    property real xCenter: width / 2
                    property real yCenter: height / 2

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();
                        ctx.moveTo(xCenter, height);
                        ctx.lineTo(xCenter - needleBaseWidth / 2, height - needleBaseWidth / 2);
                        ctx.lineTo(xCenter - needleTipWidth / 2, 0);
                        ctx.lineTo(xCenter, yCenter - needleLength);
                        ctx.lineTo(xCenter, 0);
                        ctx.closePath();
            //            ctx.fillStyle = Qt.darker(Qt.rgba(1, 1, 0.2, 1));
                        ctx.fillStyle = Qt.darker("red");
                        ctx.fill();

                        ctx.beginPath();
                        ctx.moveTo(xCenter, height)
                        ctx.lineTo(width, height - needleBaseWidth / 2);
                        ctx.lineTo(xCenter + needleTipWidth / 2, 0);
                        ctx.lineTo(xCenter, 0);
                        ctx.closePath();
                        //ctx.fillStyle = Qt.lighter(Qt.rgba(0.6, 1, 0.53, 1));
            //            ctx.fillStyle = Qt.rgba(1, 1, 0.2, 1);
                        ctx.fillStyle = "red";
                        ctx.fill();
                    }
                }

                foreground: Canvas {
                    //width: 200
                    //height: 200
            //        onPaint: {
            //            var ctx = getContext("2d");
            //            ctx.reset();
            //            paintForeground(ctx);
            //        }

                    Rectangle {
                        id: centerG
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width<parent.height?parent.width:parent.height * 0.8
                        height: width
                        color: "black"
                        border.color: "yellow"
                        border.width: 4
                        radius: width*0.5
            //             Text {
            //                  anchor.fill: parent
            //                  color: "red"
            //                  text: "Boom"
            //             }
                        gradient: Gradient {
                            GradientStop { position: 1.0; color: "black" }
                            GradientStop { position: 0.0; color: "#3B3B3B" }
                        }
                    }

                    Text {
                        id: speedText
                        font.pixelSize: toPixels(0.6)
                        text: kphInt
                        color: "white"
                        horizontalAlignment: Text.AlignRight
                        anchors.horizontalCenter: parent.horizontalCenter
            //            anchors.top: parent.top
                        anchors.top: centerG.top
                        //anchors.topMargin: toPixels(0.1)

                        readonly property int kphInt: control.value
                    }
                    Text {
                        text: "mph"
                        color: "white"
                        font.pixelSize: toPixels(0.09)
                        anchors.topMargin: toPixels(-0.1)
                        anchors.top: speedText.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Rectangle {
                        width:  centerG.width * 0.9
                        height: 5
            //            color: "#5F5F5F"
                        //color: "dimgray"
                        gradient: Gradient {
            //                GradientStop { position: 1.0; color: "black" }
            //                GradientStop { position: 0.0; color: "#3B3B3B" }
                            GradientStop { position: 1.0; color: "#3B3B3B" }
                            GradientStop { position: 0.0; color: "dimgray" }
                        }
                        //border.color: "black"
                        //border.width: 5
                        //radius: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.verticalCenter
                    }
                }

            }

        }

        CircularGauge {
            visible: true
            id: cvtTemp
            value: valueSource.mph * 10
            //anchors.verticalCenter: parent.verticalCenter
            maximumValue: 400
            width: height
            height: 150
            y: 320
            x: 625
            //anchors.right: parent.right
            //anchors.rightMargin: 20
            //anchors.bottom: parent.bottom - 50
            //anchors.top: parent.bottom

            style: CircularGaugeStyle {
                minimumValueAngle: -90
                maximumValueAngle: 90
                tickmarkInset: toPixels(0.04)
                //minorTickmarkInset: tickmarkInset
                labelStepSize: 50
                labelInset: toPixels(1.23)

                property real xCenter: outerRadius
                property real yCenter: outerRadius
                property real needleLength: outerRadius - tickmarkInset * 1.25
                property real needleTipWidth: toPixels(0.06)
                property real needleBaseWidth: toPixels(0.06)
                property bool halfGauge: true

                function toPixels(percentage) {
                    return percentage * outerRadius;
                }

                function degToRad(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function radToDeg(radians) {
                    return radians * (180 / Math.PI);
                }

                function paintBackground(ctx) {
                    if (halfGauge) {
                        ctx.beginPath();
                        ctx.rect(0, 0, ctx.canvas.width, ctx.canvas.height * 1);
                        ctx.clip();
                    }

                    ctx.beginPath();
                    ctx.fillStyle = "black";
                    ctx.ellipse(0, 0, ctx.canvas.width, ctx.canvas.height);
                    ctx.fill();

                    ctx.beginPath();
                    ctx.lineWidth = tickmarkInset;
                    ctx.strokeStyle = "black";
                    ctx.arc(xCenter, yCenter, outerRadius - ctx.lineWidth / 2, outerRadius - ctx.lineWidth / 2, 0, Math.PI * 2);
                    ctx.stroke();

                    ctx.beginPath();
                    ctx.lineWidth = tickmarkInset / 2;
                    ctx.strokeStyle = "yellow";
                    ctx.arc(xCenter, yCenter, outerRadius - ctx.lineWidth / 2, outerRadius - ctx.lineWidth / 2, 0, Math.PI * 2);
                    ctx.stroke();

                    ctx.beginPath();
                    var gradient = ctx.createRadialGradient(xCenter, yCenter, 0, xCenter, yCenter, outerRadius * 1.5);
                    gradient.addColorStop(0, Qt.rgba(1, 1, 1, 0));
                    gradient.addColorStop(0.7, Qt.rgba(1, 1, 1, 0.13));
                    gradient.addColorStop(1, Qt.rgba(1, 1, 1, 1));
                    ctx.fillStyle = gradient;
                    ctx.arc(xCenter, yCenter, outerRadius - tickmarkInset, outerRadius - tickmarkInset, 0, Math.PI * 2);
                    ctx.fill();
                }

                background: Canvas {
                    id: backGauge1
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();
                        paintBackground(ctx);
                    }
                }

                needle: Canvas {
                    implicitWidth: needleBaseWidth
                    implicitHeight: needleLength

                    property real xCenter: width / 2
                    property real yCenter: height / 2

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();
                        ctx.moveTo(xCenter, height);
                        ctx.lineTo(xCenter - needleBaseWidth / 2, height - needleBaseWidth / 2);
                        ctx.lineTo(xCenter - needleTipWidth / 2, 0);
                        ctx.lineTo(xCenter, yCenter - needleLength);
                        ctx.lineTo(xCenter, 0);
                        ctx.closePath();
            //            ctx.fillStyle = Qt.darker(Qt.rgba(1, 1, 0.2, 1));
                        ctx.fillStyle = Qt.darker("red");
                        ctx.fill();

                        ctx.beginPath();
                        ctx.moveTo(xCenter, height)
                        ctx.lineTo(width, height - needleBaseWidth / 2);
                        ctx.lineTo(xCenter + needleTipWidth / 2, 0);
                        ctx.lineTo(xCenter, 0);
                        ctx.closePath();
                        //ctx.fillStyle = Qt.lighter(Qt.rgba(0.6, 1, 0.53, 1));
            //            ctx.fillStyle = Qt.rgba(1, 1, 0.2, 1);
                        ctx.fillStyle = "red";
                        ctx.fill();
                    }
                }

                foreground: Canvas {

                    Rectangle {
                        id: centerG1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width<parent.height?parent.width:parent.height * 0.8
                        height: width
                        color: "black"
                        border.color: "yellow"
                        border.width: 1
                        radius: width*0.5

                        gradient: Gradient {
                            GradientStop { position: 1.0; color: "black" }
                            GradientStop { position: 0.0; color: "#3B3B3B" }
                        }
                    }

                    Text {
                        id: speedText1
                        font.pixelSize: 55
                        text: kphInt
                        color: "white"
                        //horizontalAlignment: Text.AlignLeft
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.top: parent.top
                        //anchors.left: centerG.left
                        //anchors.leftMargin: 15
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.topMargin: toPixels(0.1)

                        readonly property int kphInt: control.value
                    }
                    Text {
                        text: "CVT"
                        color: "white"
                        font.pixelSize: 20
                        font.bold: true
                        anchors.topMargin: 7
                        anchors.top: centerG.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                }
            }
        }

        Rectangle{
            id: fuelLevel
            height: 225
            width: 100
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.right: parent.left
            anchors.leftMargin: 60
            color: "#2E2E2E"

            ProgressBar {
                id: fuelBar

                value: 0

                anchors.fill: parent
                anchors.margins: 5
                orientation: Qt.Vertical
                style: ProgressBarStyle {

                    background: Rectangle {
                        radius: 2
                        color: "dimgray"
                        //border.color: "gray"
                        //border.width: 3
                        implicitWidth: 200
                        implicitHeight: 24
                        gradient: Gradient {
                            GradientStop { position: 1.0; color: "black" }
                            GradientStop { position: 0.0; color: "#3B3B3B" }
                        }
                    }
                    progress: Rectangle {
                        color: "lawngreen"
                        border.color: "#00000000"
                        border.width: 3

                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "lawngreen" }
                            GradientStop { position: 1.0; color: "green" }
                        }

                    }
                }

                NumberAnimation {
                    loops: 5
                    running: true
                    target: fuelBar
                    property: "value"
                    easing.type: Easing.Linear
                    from: 1
                    to: 0
                    duration: 600000
                }
            }

        }


        MouseArea { id: mouseAreaExit; anchors.fill: infoBar }
        //MouseArea { id: mouseAreaEnter; anchors.fill: background }

        states: [
            State {
                name: "final"
                //when: mouseAreaEnter.pressed
                when: Keys.onRightPressed
                AnchorChanges { target: infoBar; anchors.top: parent.top }
                AnchorChanges { target: infoBar; anchors.bottom: undefined }

                AnchorChanges { target: currentTimeBar; anchors.left: parent.left }
                AnchorChanges { target: currentTimeBar; anchors.right: undefined }

                AnchorChanges { target: fastestTimeBar; anchors.right: parent.right }
                AnchorChanges { target: fastestTimeBar; anchors.left: undefined }

                AnchorChanges { target: lapBar; anchors.right: parent.right }
                AnchorChanges { target: lapBar; anchors.left: undefined }

                AnchorChanges { target: fuelLevel; anchors.left: parent.left }
                AnchorChanges { target: fuelLevel; anchors.right: undefined }
            },
            State {
                name: "exit"
                when: mouseAreaExit.pressed
                //when: Keys.onLeftPressed

                AnchorChanges { target: infoBar; anchors.bottom: parent.top }
                AnchorChanges { target: infoBar; anchors.top: undefined }

                AnchorChanges { target: currentTimeBar; anchors.right: parent.left }
                AnchorChanges { target: currentTimeBar; anchors.left: undefined }

                AnchorChanges { target: fastestTimeBar; anchors.left: parent.right }
                AnchorChanges { target: fastestTimeBar; anchors.right: undefined }

                AnchorChanges { target: lapBar; anchors.left: parent.right }
                AnchorChanges { target: lapBar; anchors.right: undefined }

                AnchorChanges { target: fuelLevel; anchors.right: parent.left }
                AnchorChanges { target: fuelLevel; anchors.left: undefined }
            }
        ]

        transitions: [
            Transition {
               to: "final"; reversible: true
               // smoothly reanchor myRect and move into new position
               AnchorAnimation {
                   easing.type: Easing.InOutQuad
                   duration: 3000
               }
               PropertyAnimation {
                   target: speedometer
                   property: "y"
                   from: 500
                   to: 220
                   duration: 3000
                   easing.type: Easing.InOutSine
               }
           },

            Transition {
                to: "exit"; reversible: true
                // smoothly reanchor myRect and move into new position
                AnchorAnimation {
                   easing.type: Easing.InOutQuad
                   duration: 4000
                }
                PropertyAnimation {
                   target: speedometer
                   property: "y"
                   from: 220
                   to: 500
                   duration: 4000
                   easing.type: Easing.InOutSine
                }
                onRunningChanged: {
                    console.log("Running:", running)
                }
            }
        ]

        //Component.onCompleted: container.state = "final"
        //background.pressed: container.state = "exit"
        MouseArea {
            anchors.fill: parent
            enabled: false
            cursorShape: Qt.BlankCursor
       }

    }


//    Item {
//        id: graph
//        objectName: 'graphObj'
//        visible: true
//        width: 800
//        height: 480
//        anchors.fill: parent

//        ChartView {
//            id: chart
//            objectName: "chartObj"
//            //animationOptions: ChartView.AllAnimations
//            animationOptions: ChartView.SeriesAnimations
//            animationEasingCurve : easing
//            theme: ChartView.ChartThemeDark
//            property bool openGL: true
//            property bool openGLSupported: true
//            anchors.fill: parent
//            antialiasing: true

//            legend {
//                visible: false
//            }

//            axes: [
//                    ValueAxis{
//                        id: xAxis
//                        min: 0.0
//                        max: 0.0
//                    },
//                    ValueAxis{
//                        id: yAxis
//                        min: 0.0
//                        max: 0.0
//                    }
//                ]
//            property var shit: SplineSeries {
//                   name: ""
//                   objectName: "linesObj"
//                   axisX: xAxis
//                   axisY: yAxis
//                   useOpenGL: chartView.openGL
//                   color: "yellow"
//               }

//            property var shit2: SplineSeries {
//                   name: ""
//                   objectName: "linesObj"
//                   axisX: xAxis
//                   axisY: yAxis
//                   useOpenGL: chartView.openGL
//                   color: "goldenRod"
//               }


//            function makeChart (x, y) {
//                //LineSeries.append(x, y)
//                //var series = chart.createSeries(ChartView.SeriesTypeLine, "line", xAxis, yAxis)
//                xAxis.max = x + 10
//                xAxis.min = x - 100
//                if (x > xAxis.max){
//                    //xAxis.max = x + 10
//                    //xAxis.min = x - 100
//                    scrollRight(10)
//                }
//                if (y > yAxis.max - 5){
//                    yAxis.max = y + 10
//                    yAxis.min = (y*-1) - 10
//                }
//                if (y < yAxis.min + 5){
//                    yAxis.min = y - 10
//                    yAxis.max = (y*-1) + 10
//                }

//                //shit = line
//                shit.append(x, y)
//                shit2.append(x, 10+ Math.cos(y)*10)

//            }

//        }
//    }

//    loadingScreen {
//        id: loadingScreen
//    }

    Item {
        id: loadingScreen
        objectName: 'loadingObj'
        visible: true
        width: 800
        height: 480
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
                    duration: 5000
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

}
