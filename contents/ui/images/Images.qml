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

                    ColumnLayout {
                        NextForecastView {
                            id: nextForecastView
                        }
                    }

                    onClicked: {
                        if (nextForecastView.visible) {
                            nextForecastView.visible = false;
                        }
                        else {
                            nextForecastView.visible = true;
                        }

                    }//onClicked
                }//MouseArea
            }//Image

        }//Item
    }//PlasmaCore.IconItem
}//Image

