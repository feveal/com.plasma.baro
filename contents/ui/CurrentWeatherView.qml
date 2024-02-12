import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import Qt.labs.platform 1.0 as Platform
import "images"

Item {
	id:temp

	Images {
		id: images
	}
		WLabel {
			Layout.fillWidth: true
			Layout.preferredWidth: 60 * PlasmaCore.Units.devicePixelRatio
			id: currentConditionsLabel
		x: 5 * parentContainer.scaleFactor
		y: 380 * parentContainer.scaleFactor

			text: weatherData.todaysForecastLabel
			font.pixelSize: currentWeatherView.forecastFontSize
			elide: Text.ElideRight
			wrapMode: Text.WordWrap

			PlasmaCore.ToolTipArea {
				anchors.fill: parent
				mainText: currentConditionsLabel.text
				enabled: currentConditionsLabel.truncated
			}
		}

GridLayout {
	id: currentWeatherView
	columns: 1
	//--- Settings
	readonly property int forecastFontSize: plasmoid.configuration.forecastFontSize * PlasmaCore.Units.devicePixelRatio
	readonly property int tempFontSize: plasmoid.configuration.tempFontSize * PlasmaCore.Units.devicePixelRatio
		// Posición de temperatura
		x: 10 * parentContainer.scaleFactor
		y: 400 * parentContainer.scaleFactor

		Layout.fillHeight: true

		Item {
			implicitHeight: currentTempLabel.font.pixelSize
			implicitWidth: currentTempLabel.implicitWidth
			WLabel {
				id: currentTempLabel
				anchors.verticalCenter: parent.verticalCenter
				font.pixelSize: currentWeatherView.tempFontSize
				readonly property var value: weatherData.currentTemp
				readonly property bool hasValue: !isNaN(value)
/*
//--------------
Connections {
    target: weatherData
    onCurrentTempChanged: {
        // Acciones a realizar cuando cambia la temperatura
        var value = weatherData.currentTemp;
        var hasValue = !isNaN(value);
        var valor = hasValue ? weatherData.formatTempShort(value) : "";
        console.log ("------->:  " + valor)
    }
}
//--------------
*/

			text: hasValue ? weatherData.formatTempShort(value) : ""

			}

		}
		Item {

			WLabel {
				id: updatedAtLabel
				x:0 * parentContainer.scaleFactor
				y:50 * parentContainer.scaleFactor
				horizontalAlignment: Text.AlignHCenter

				font.pixelSize: plasmoid.configuration.detailsFontSize * PlasmaCore.Units.devicePixelRatio

				readonly property var value: weatherData.oberservationTimestamp
				readonly property bool hasValue: !!value // && !isNaN(new Date(value))
				readonly property date valueDate: hasValue ? new Date(value) : new Date()
				text: {
					if (hasValue) {
						var timestamp = Qt.formatTime(valueDate, Qt.DefaultLocaleShortDate)
						if (timestamp) {
							return i18n("Updated at %1", timestamp)
						} else {
							return ""
						}
					} else {
						return ""
					}
				}
				opacity: 0.6
				wrapMode: Text.Wrap
			}
		}

		Item {
				WLabel {
				id: locationLabel
				x:0 * parentContainer.scaleFactor
				y:70 * parentContainer.scaleFactor
				Layout.fillWidth: true
				horizontalAlignment: Text.AlignHCenter
//				font.pixelSize: detailsView.detailsFontSize
				readonly property var value: weatherData.location
				readonly property bool hasValue: !!value
				text: hasValue ? value : ""
				opacity: 0.6
				wrapMode: Text.Wrap
			}

			NoticesListView {
				Layout.fillWidth: true
				model: weatherData.watchesModel
				readonly property bool showWatches: plasmoid.configuration.showWarnings
				visible: showWatches && model.length > 0
				state: "Watches"
				horizontalAlignment: Text.AlignHCenter
			}

			NoticesListView {
				Layout.fillWidth: true
				model: weatherData.warningsModel
				readonly property bool showWarnings: plasmoid.configuration.showWarnings
				visible: showWarnings && model.length > 0
				state: "Warnings"
				horizontalAlignment: Text.AlignHCenter
			}
		}

}
			DetailsView {
				id: detailsView
				x: 350 * parentContainer.scaleFactor
				y: 400 * parentContainer.scaleFactor
				visible: plasmoid.configuration.showDetails
				Layout.alignment: Qt.AlignTop
				model: weatherData.detailsModel
			}
}

