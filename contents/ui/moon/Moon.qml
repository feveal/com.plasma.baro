import QtQuick 2.7
import QtQuick.Layouts 1.1
import Qt.labs.platform 1.0 as Platform

Item {
    id: moon
    opacity: 0.1
    x: 110 * parentContainer.scaleFactor
    y: 270 * parentContainer.scaleFactor
//Component.onCompleted: {console.log ("Hola")}
    Image {
        id: moonImage
        width: 40 * parentContainer.scaleFactor
        height: 40 * parentContainer.scaleFactor
        x: 1
        y: 2
        z: 2
        opacity: 1
//        scale: moonData.state === "clicked" ? 3 : 0.5  // Reduce la escala cuando el estado es "clicked"
		source: "../moon/" + moonComponent.moonPhase + ".png"

        MouseArea {
            id: mouseMoon
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                // Cambia el estado de moonData para activar la transición de escala
                moonData.state = moonData.state === "clicked" ? "" : "clicked";
            }
        }
        Rectangle {
            width: (moonLabelIlu.width + 20) * parentContainer.scaleFactor // Ajusta el ancho del rectángulo según el texto
            height: (moonLabelIlu.height + 2) * parentContainer.scaleFactor // Ajusta el alto del rectángulo según el texto
            color: "lightgray"  // Color del fondo del rectángulo
            radius: 2  // Opcional: si deseas esquinas redondeadas en el fondo del rectángulo
            x: moonLabelIlu.x - 3 * parentContainer.scaleFactor // Ajusta la posición x del rectángulo según el texto
            y: moonLabelIlu.y + 36 * parentContainer.scaleFactor // Ajusta la posición y del rectángulo según el texto

            Text {
                id: moonLabelIlu
                x: 2 * parentContainer.scaleFactor
                y: 0 * parentContainer.scaleFactor
                color: "black"  // Color del texto
                font.pixelSize: 4 * parentContainer.scaleFactor // Tamaño de la fuente
                style: Text.Raised;  // Estilo del texto
                styleColor: "white"  // Color del estilo del texto
                text: {
                    var moonphaseText = "";
                    if (moonComponent.moonPhase !== undefined && moonComponent.moonPhase !== "") {
                        moonphaseText += i18n(moonComponent.moonPhase);
                    }
                    return moonphaseText + "; " + i18n(" Lightning: ") + moonComponent.percentIlu + "%";
                }
            }
        }
        Rectangle {
            width: (moonDaysPhase.width + 20) * parentContainer.scaleFactor
            height: (moonDaysPhase.height + 2) * parentContainer.scaleFactor
            color: "lightgray"  // Color del fondo del rectángulo
            radius: 2  // Opcional: si deseas esquinas redondeadas en el fondo del rectángulo
            x: moonLabelIlu.x - 3 * parentContainer.scaleFactor // Ajusta la posición x del rectángulo según el texto
            y: moonLabelIlu.y + 46 * parentContainer.scaleFactor // Ajusta la posición y del rectángulo según el texto
            Text {
                id: moonDaysPhase
                x: 2 * parentContainer.scaleFactor
                y: 0 * parentContainer.scaleFactor
                color: "black"
                font.pixelSize: 4 * parentContainer.scaleFactor
                style: Text.Raised;
                styleColor: "white"
                text: {
                    var phaseText = moonComponent.daysPhase + i18n(" days for ");
                    if (moonComponent.nextPhase !== undefined && moonComponent.nextPhase !== "") {
                        phaseText += i18n(moonComponent.nextPhase);
                    }
                    return phaseText;
                }
            }
        }
    }

    // Contenedor para los datos de la luna
    Item {
        id: moonData
        // Define los estados y transiciones para la animación de escala
        states: [
			State {
                name: "clicked"
                PropertyChanges {
                    target: moon
                    scale: 3
                    opacity: 1
                    x: -180 * parentContainer.scaleFactor // Posicion de luna
                    y: 40 * parentContainer.scaleFactor
                }
            }
        ]

        transitions: [
            Transition {
                from: "clicked"; to: "*"
                NumberAnimation { properties: "scale, opacity"; duration: 2000 }
                NumberAnimation { properties: "x, y "; duration: 700 }
            },
            Transition {
                from: "*"; to: "clicked"
                NumberAnimation { properties: "scale, opacity"; duration: 700 }
                NumberAnimation { properties: "x, y "; duration: 2000 }
            }
        ]
    }
//-------------------------

    Timer {
        id: refreshTimer
        interval: 900000 // Intervalo de actualización en milisegundos (1 minuto = 60000)
        repeat: true
        running: true // Comienza a correr automáticamente
        onTriggered: {
            moonComponent.refresh()
        }
    }

//-------------------------

}

