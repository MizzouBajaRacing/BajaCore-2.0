#!/usr/bin/env python
# -*- coding: utf-8 -*-


from PyQt5.QtCore import pyqtProperty, QRectF, QUrl, QObject, pyqtSignal, pyqtSlot, QVariant, QThread, QTimer, QCoreApplication, qDebug
from PyQt5.QtGui import QColor, QGuiApplication, QPainter, QPen, QPolygonF
from PyQt5.QtQml import qmlRegisterType, QQmlComponent, QQmlEngine
from PyQt5.QtQuick import QQuickItem, QQuickPaintedItem, QQuickView
from PyQt5 import QtNetwork as QN
from PyQt5 import QtCore as QC
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5 import QtGui, QtCore
import sys
import os
import time
import datetime
#from pyqtgraph.Qt import QtGui, QtCore
from PyQt5.QtWidgets import QGraphicsView, QGraphicsScene, QGraphicsWidget, QGraphicsLinearLayout
#from PyQt5.QtChart import QChart, QChartView, QLineSeries
import math
import PyQt5
os.environ["QML2_IMPORT_PATH"] = "/usr/lib/arm-linux-gnueabihf/qt5/plugins/PyQt5/libpyqt5qmlplugin.so"

class Main(QObject):
    def __init__(self,parent=None):
        super().__init__(parent)
        self.engine = QQmlApplicationEngine(self)
        self.engine.load(QUrl.fromLocalFile('qml/dashboard.qml'))
        self.win = self.engine.rootObjects()[0]


    def show(self):
        self.win.show()

        self.values = self.win.findChild(QObject,'valueSourceObj')

        self.chartV = self.win.findChild(QObject,'chartObj')

        self.stopSig = pyqtSignal(object)


        self.load = load()
        self.loadThread = QThread()
        self.load.doneSig.connect(self.displayDash)
        self.load.moveToThread(self.loadThread)
        self.loadThread.started.connect(self.load.start)
        self.loadThread.start()


        self.oldSpeed = 0

        self.gps = gpsSpeed()
        self.thread = QThread()
        self.gps.speedSig.connect(self.updateSpeed)
        self.gps.moveToThread(self.thread)
        self.thread.started.connect(self.gps.start1)
        # self.thread.start()
        
        #self.gps.startTimer()
        
        # self.process = QProcess(self)
        # self.process.speedSig.connect(self.updateSpeed)

        self.timer = timerModule()
        self.thread1 = QThread()
        self.timer.timeSig.connect(self.updateTime)
        self.timer.lineSig.connect(self.updateGraph)
        self.timer.moveToThread(self.thread1)
        self.thread1.started.connect(self.timer.run)
        # self.thread1.start()

        #self.graph = self.win.findChild(QObject,'chartObj')

    def updateGraph (self, x, y):
        #self.chartV.makeChart(x, y)
        pass
  

    def displayDash (self):

        self.loadingScreen = self.win.findChild(QObject,'loadingObj')   

        self.container = self.win.findChild(QObject,'containerObj')

        self.loadingScreen.setProperty('visible', 'false')
        self.container.setProperty('visible', 'true')

        self.container.setProperty('state', 'final') 
        self.thread.start()   
        self.thread1.start()

          


    def updateSpeed (self, speed):
        #self.values.setProperty('kph', speed)
        #print("Old: " + str(self.oldSpeed) + " | New: " + str(speed))
        self.values.updateSpeed(speed, self.oldSpeed)
        self.oldSpeed = speed
        if speed > 40:
            #self.container.setProperty('state', 'exit')
            self.gps.reset()


    def updateTime (self, time):
        self.values.setProperty('currTime', time)



class gpsSpeed (QObject):
    speedSig = pyqtSignal(int)

    def __init__(self, parent=None):
        super().__init__(parent)
        #parent.stopSig.connect(self.stop)
        # self.timer = QTimer(self)
        # self.timer.timeout.connect(self.incSpeed)
        # self.startTimer()
    

    def startTimer(self):
        self.timer.start(1000)
        self.speed = 0.1

            

    def start1(self):
        self.speed = 0.1
        self.time = time.time()
        #self.timer.start(1000)

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.incSpeed)
        self.startTimer()
        self.timer.start(1000)

        # while True:
        #     if (self.time + 1) < time.time(): 
        #         self.speed +=  (self.speed * 0.3) + 0.5
        #         self.time = time.time()
        #         self.speedSig.emit(self.speed)
                # with open('/dev/urandom', 'rb') as f:
                #     for x in range(100):
                #         f.read(4 * 65535)
            #print(speed)
            #self.speedSig.emit(speed)
            

    def incSpeed (self):
        self.speed +=  (self.speed * 0.3) + 0.5
        #self.time = time.time()
        self.speedSig.emit(self.speed)
        #self.longF()
        # with open('/dev/urandom', 'rb') as f:
        #     for x in range(100):
        #         f.read(4 * 65535)

    def longF (self):
        for i in range(100):
            time.sleep(0.01)

    def reset (self):
        self.speed = 0
            

class timerModule (QObject):
    timeSig = pyqtSignal(object)
    lineSig = pyqtSignal(int, int)

    def __init__(self, parent=None):
        super().__init__(parent)
        #parent.stopSig.connect(self.stop)
    
    def run(self):
        time.sleep(2)
        startTime = datetime.datetime.now()
        val = 0
        for i in range(1):
            val += 1
            self.lineSig.emit(val, val * math.sin(val))
            time.sleep(0.2)

        while True:
            elapsed = datetime.datetime.now() - startTime 
            minute = str(int(elapsed.seconds/60))
            timeStr = minute.zfill(2)  + ":" + str(elapsed.seconds%60).zfill(2)  + "." + str(elapsed.microseconds)[:2].zfill(2) 
            self.timeSig.emit(timeStr)
            time.sleep(0.08)

    def stop (self):
        return

class load (QObject):
    doneSig = pyqtSignal()

    def __init__(self, parent=None):
        super().__init__(parent)
        #parent.stopSig.connect(self.stop)
        # self.timer = QTimer(self)
        # self.timer.timeout.connect(self.incSpeed)
        # self.startTimer()

    def start(self):
        time.sleep(6)
        self.doneSig.emit()
    

def main2 ():
    app = QtGui.QApplication(sys.argv)

    main = Main()
    main.show()
    
    sys.exit(app.exec_())


def main ():
    app = QGuiApplication(sys.argv)

    current_path = os.path.abspath(os.path.dirname(__file__))
    qml_file = os.path.join(current_path, 'qml/dashboard.qml')

    engine = QQmlApplicationEngine()
    engine.load(QUrl.fromLocalFile(qml_file))


    ctx = engine.rootContext()
    win = engine.rootObjects()[0]
    py_mainapp = MainApp(ctx, win)

    engine.rootContext().setContextProperty("py_mainapp", py_mainapp)


    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())


if __name__ == '__main__':
    main2()

