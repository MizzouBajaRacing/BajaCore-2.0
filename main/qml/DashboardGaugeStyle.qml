import QtQuick 2.2
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle {
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
