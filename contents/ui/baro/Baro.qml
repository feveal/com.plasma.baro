import QtQuick 2.3

import QtQuick.Controls 2.2 as QtControls
import "/libweather" as LibWeather
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.private.weather 1.0 as WeatherPlugin
import "/libweather/WeatherData.qml" as WeatherData
import "../libweather"

Item {
    id: baro

        Image {
            id: needleShadow;

            x: 275 * parentContainer.scaleFactor - (width / 2) // Posicion giro
            y: 190 * parentContainer.scaleFactor - height + 2

            width: 300 * parentContainer.scaleFactor // Ancho imagen
            height: 40 * parentContainer.scaleFactor

            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            source: "sombra_aguja.png"

                transform: Rotation {
                    id: needleShadowRotation

//---------------
                    property var angNeedle: 0

                    function ruleUnits(angNeedle) {
                        var value = weatherData.currentTemp;
                        // Verificar la unidad de temperatura actual y aplicar la regla correspondiente
                        if (weatherData.tempUnits === 6000) {
                            // Kelvin
                            return (-4.8 + value * 0.55);
                        } else if (weatherData.tempUnits === 6001) {
                            // Celsius
//                           console.log ("Celsius:  " + value);
                            return (-4.8 + value * 0.55);
                        } else if (weatherData.tempUnits === 6002) {
                            // Fahrenheit
//                            console.log ("Fahrenheit:  " + value);
                            return (-14.5 + value * 0.304);
                        } else {
                            // Unidad de temperatura desconocida
//                            console.log("N/A");
                            return 0;
                        }
                    }

//---------------

                    origin.x: needleShadow.paintedWidth - (needleShadow.paintedWidth / 6) // Punto de giro en la aguja
                    origin.y: needleShadow.paintedHeight - 2

                    angle: ruleUnits (angNeedle)
                }
        }

    Item {
        id: baroItem
// Tamaño inicial
        property int ojectWidth: 450 * parentContainer.scaleFactor
        property int ojectHeight: 450 * parentContainer.scaleFactor

//------------
        readonly property var value: weatherData.currentTemp
        readonly property bool hasValue: !isNaN(value)

        property alias displayUnits: displayUnits
                DisplayUnits { id: displayUnits }


        Image {
            id: backgroundShadow;

            x:12 * parentContainer.scaleFactor
            y:12 * parentContainer.scaleFactor

            width: parent.ojectWidth
            height: parent.ojectHeight

            smooth: true
            mipmap: true
            source: "sombra_baro.png"
        }

        Image {
            id: background;

            property point center : Qt.point(width / 2, height / 2);
            width: parent.ojectWidth
            height: parent.ojectHeight

            smooth: true
            mipmap: true
            source: "baro.png"



        }

        Image {
            id: baroSupport;

            x: (348*parentContainer.scaleFactor)
            y: (136*parentContainer.scaleFactor)

            width: 26 * parentContainer.scaleFactor // 108 for inner radius
            height: 90 * parentContainer.scaleFactor // 108 for inner radius

            property int outerRingRadius: baroSupport.paintedWidth / 2
            property int outerRingRadiusSquare: outerRingRadius * outerRingRadius
            property int innerRingRadius: baroSupport.paintedWidth / 2 - 20 * parentContainer.scaleFactor
            property int innerRingRadiusSquare: innerRingRadius * innerRingRadius

            smooth: true
            mipmap: true
            source: "soporte_aguja.png"

        }

        Image {
            id: ruler;

            property point center : Qt.point(width / 2, height / 2);
            width: parent.ojectWidth
            height: parent.ojectHeight

            function rulerImage (ruler) {
                        if (displayUnits.temperatureUnitId == 6000) {
                                return "regla_K.png"
                        }
                        if (displayUnits.temperatureUnitId == 6001) {
                                return "regla_C.png"
                        }
                            else { (displayUnits.temperatureUnitId == 6002)
                                return "regla_F.png"
                            }
            }
//    Component.onCompleted: {console.log (rulerImage (ruler))}
            smooth: true
            mipmap: true
            source: rulerImage (ruler)
        }

    Item {
        id: needleItem

        Image {
            id: needle;

            x: 245 * parentContainer.scaleFactor - (width / 2) // Posicion giro
            y: 170 * parentContainer.scaleFactor - height + 2

            width: 300 * parentContainer.scaleFactor // Ancho imagen
            height: 40 * parentContainer.scaleFactor

            fillMode: Image.PreserveAspectFit
            smooth: true
            mipmap: true
            source: "aguja.png"

                transform: Rotation {
                    id: needleRotation
                    readonly property var value: weatherData.intValueTemp

//---------------
                    property var angNeedle: 0

                    function ruleUnits(angNeedle) {
                        var value = weatherData.currentTemp;
                        // Verificar la unidad de temperatura actual y aplicar la regla correspondiente
                        if (weatherData.tempUnits === 6000) {
                            // Kelvin
                            return (-4.8 + value * 0.55);
                        } else if (weatherData.tempUnits === 6001) {
                            // Celsius
//                            console.log ("Celsius:  " + value);
                            return (-4.8 + value * 0.55);
                        } else if (weatherData.tempUnits === 6002) {
                            // Fahrenheit
//                            console.log ("Fahrenheit:  " + value);
                            return (-14.5 + value * 0.304);
                        } else {
                            // Unidad de temperatura desconocida
//                            console.log("Unidad de temperatura desconocida");
                            return 0;
                        }
                    }
// En Celsius -15.5 equivale a "-20º", -4.8 a "0º", 6 a "20º", 17 a "40º"
// el angulo es a partir de -15.5 sumandole 0,55 por cada grado entre -20º y 40º
// En Farenheight es -14.5 y el paso 0.304
//---------------
// Component.onCompleted: {console.log (">>>: " + angNeedle)}

                    origin.x: needle.paintedWidth - (needle.paintedWidth / 6) // Punto de giro en la aguja
                    origin.y: needle.paintedHeight - 2

                    angle: ruleUnits (angNeedle)

                        }
        }

//----------- Mouse

                Image {
                    id: animationImage
                    x: 170 * parentContainer.scaleFactor
                    y: 264 * parentContainer.scaleFactor
                    width: 100 * parentContainer.scaleFactor
                    height: 37 * parentContainer.scaleFactor

                    source: "anemometro/ane-1.png"
                    visible: true
                    MouseArea {
                        id: mouseAction
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            animationImage.visible = true;
                            animationTimer.running = !animationTimer.running;
                        }
/*
                        onPressed: {
                            console.log ("--")
                        }
                        onReleased: {
                            console.log ("---")
                        }
                        onPositionChanged: {
                            console.log ("----")
                        }

                        onEntered: {
                            cursorShape = Qt.PointingHandCursor;
                            animationTimer.running = !animationTimer.running;
                            if (!animationTimer.running) {
                            animationTimer.start();
                            }
                        }

                        // Al pasar el ratón por encima
                            animationTimer.running = !animationTimer.running;

                        onExited: {
                            cursorShape = Qt.ArrowCursor;
                        // Al salir el ratón del plasmoide
                           console.log("El ratón ha salido del plasmoide.")
                        }
*/
                    }
                        // Timer para cambiar las imágenes
                        Timer {
                            id: animationTimer
                            interval: (300 / (weatherData.intWindSpeed() / 2) + 1)
                            repeat: true
                            running: true
                            property int currentImageIndex: 1;
                            onTriggered: {
                                currentImageIndex = (currentImageIndex % 8) + 1;
                                animationImage.source = "anemometro/ane-" + currentImageIndex + ".png";
//                                console.log (interval)
                            }
                        }
                }
//-----------

        }

    }

}
