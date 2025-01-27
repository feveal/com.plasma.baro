import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import "../libweather"

import org.kde.plasma.components 3.0

Image {
    id: images

    //--- Settings
    readonly property int forecastFontSize: plasmoid.configuration.forecastFontSize * PlasmaCore.Units.devicePixelRatio
    readonly property int tempFontSize: plasmoid.configuration.tempFontSize * PlasmaCore.Units.devicePixelRatio

    //--- Layout
    PlasmaCore.IconItem {
        id: currentForecastIcon
        Layout.fillHeight: true
        roundToIconSize: false

        //----

        Item {
            property int ojectWidth: 150 * parentContainer.scaleFactor
            property int ojectHeight: 110 * parentContainer.scaleFactor

            Image {

                x:100 * parentContainer.scaleFactor
                y:360 * parentContainer.scaleFactor

                width: parent.ojectWidth
                height: parent.ojectHeight

                // Filtrar el nombre del icono antes de añadir la extensión ".png"
                source: "../images/" + sanitizeIconName(weatherData.currentConditionIconName) + ".png"

                // Función para quitar "-day" o "-night" del nombre del icono
                function sanitizeIconName(iconName) {
                    if (iconName.endsWith("-day")) {
                        const sanitized = iconName.slice(0, -4); // Quitar "-day"
                        return sanitized;
                    } else if (iconName.endsWith("-night")) {
                        const sanitized = iconName.slice(0, -6); // Quitar "-night"
                        return sanitized;
                    }
                    return iconName; // Si no termina en "-day" o "-night", devolver tal cual
                }

                MouseArea {
                    id: mouseDetails
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    ColumnLayout {
                        NextForecastView {
                            id: nextForecastView
                        }
                    }

                    onClicked: {
                        nextForecastView.state == 'clicked' ? nextForecastView.state = "": nextForecastView.state = 'clicked';
/*
                        if (nextForecastView.visible) {
                            nextForecastView.visible = false;
                        }
                        else {
                            nextForecastView.visible = true;
                        }
*/
                    }//onClicked
                }//MouseArea
            }//Image

        }//Item
    }//PlasmaCore.IconItem
}//Image

