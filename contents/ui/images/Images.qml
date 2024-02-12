import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

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
//            Component.onCompleted: {console.log("Ruta del directorio en Images:", source)}
			}
        }
//----
	}
}
