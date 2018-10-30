import QtQuick 2.2
//! [0]
Item {
    id: valueSource
    objectName: 'valueSourceObj'

    //signal messageRequired;
    property real oldMPH: 0
    property real newMPH: 0
    property real durr: 0
    function updateSpeed(speed, oldSpeed) {
        newMPH = speed
        oldMPH = oldSpeed
        //durr =  ((2600*(speed - oldSpeed)) / (speed - oldSpeed))
        durr =  ((1050*(speed - oldSpeed)) / (speed - oldSpeed))
        //durr =  1000
        animateSpeed.restart()


    }


    property bool startSpeed: false
    NumberAnimation {
        id: animateSpeed
        //loops: 1
        //running: false
        target: valueSource
        property: "mph"
        easing.type: Easing.Linear
        from: oldMPH
        to: newMPH
        duration: durr
    }

    property real mph: 0
    property string currTime: "00:00.00"
    property real rpm: 1
    property real fuel: 0.85
}
