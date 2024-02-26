import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import "../libweather"

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

                source: "../images/" + weatherData.currentConditionIconName + ".png"

                MouseArea {
                    id: mouseDetails
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        // Si la imagen está visible, ocúltala
                        if (dynamicImage.visible) {
                            dynamicImage.visible = false;
                            tomorrowDescription.visible = false;
                        } else {
                            var values = weatherData.parseForecast(0);
                            if (values.length >= 4) {
                                var day = values[0];
                                var imageName = values[1] + ".png";
                                var description = values[2];
                                var maxTemp = values[3];
                                var minTemp = values[4];
                                dynamicImage.source = imageName


                                tomorrowDescription.font.pixelSize = 9
                                tomorrowDescription.text =  day + ": " + description + "\n" + i18n("Max: ") + maxTemp + "\n" + i18n("Mín: ") + minTemp;
                                // Muestra la imagen y el texto
                                dynamicImage.visible = true;
                                tomorrowDescription.visible = true;

                                console.log ("dia: " + imageName + " : " + description + "max: " + maxTemp + "min: " + minTemp)

                            } else {
                                console.error("Error Function");
                            }//else
                        }//else
                    }//onClicked
                }//MouseArea
            }//Image

            Item {
                id: dynamicImageContainer
                x: 100 * parentContainer.scaleFactor
                y: 550 * parentContainer.scaleFactor
                Image {
                    id: dynamicImage
                    anchors.centerIn: parent
                    visible: false // Inicialmente oculto
                    width: 100 * parentContainer.scaleFactor
                    height: 70 * parentContainer.scaleFactor
                }

                Text {
                    id: tomorrowDescription
                    anchors {
                        horizontalCenter: dynamicImageContainer.horizontalCenter
                        top: dynamicImageContainer.bottom
                    }
                    color: "white"
                    style: Text.Outline
                    styleColor: "black"
                    width: 1
                }
            }//Item

        }//Item
    }//PlasmaCore.IconItem
}//Image

