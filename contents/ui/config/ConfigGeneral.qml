import QtQuick 2.5
import QtQuick.Controls 2.0 as QQC2
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.private.weather 1.0 as WeatherPlugin
import "../libweather" as LibWeather
import "../libconfig" as LibConfig

Kirigami.FormLayout {
	Layout.fillWidth: true

	property alias displayUnits: displayUnits
	DisplayUnits { id: displayUnits }

	LibWeather.ConfigWeatherStationPicker {
		configKey: 'source'
	}
	LibWeather.WeatherStationCredits {
		id: weatherStationCredits
	}

	LibConfig.SpinBox {
		Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:spinbox", "Update every:")
		configKey: "updateInterval"
		suffix: i18ndc("plasma_applet_org.kde.plasma.weather", "@item:valuesuffix spacing to number + unit (minutes)", " min")
		stepSize: 5
		from: 30
		to: 3600
	}

	ColumnLayout {

		Item {
			implicitWidth: Kirigami.Units.largeSpacing * 2
		}
		LibConfig.CheckBox {
			configKey: "showWarnings"
			text: i18n("Show weather warnings")
//			enabled: showDetails.checked
		}

		ColumnLayout {
			Kirigami.Heading {
				Layout.fillWidth: true
				level: 0
				text: ""
			}
		}

		Kirigami.Separator {
			Layout.fillWidth: true
		}

		GridLayout {
			columns: 2
			Kirigami.Heading {
				level: 0
				text: i18n("Degrees Units:")
			}

			Component.onCompleted: {
				temperatureComboBox.populateWith(displayUnits.temperatureUnitId)

//				console.log (">>>>> " + displayUnits.temperatureUnitId)
			}

			LibConfig.ComboBox {
//--------------
				property string configKey

				textRole: "display"

				property bool populated: false
				enabled: populated

				onCurrentIndexChanged: {
					// console.log('currentIndex', currentIndex, populated)
					if (configKey && model && model.unitIdForListIndex && populated) {
						var nextValue = model.unitIdForListIndex(currentIndex)
						serializeWith(nextValue)
					}
				}

				function populateWith(unitId) {
					// console.log('populateWith', unitId, model, model && model.unitIdForListIndex)
					if (model && model.unitIdForListIndex) {
						currentIndex = model.listIndexForUnitId(unitId)
						populated = true
					}
				}

				function serializeWith(nextValue) {
					// console.log('UrlComboBox.serializeWith', nextValue)
					if (plasmoid.configuration[configKey] === nextValue) {
						return
					}
					plasmoid.configuration[configKey] = nextValue
				}
//--------------
					id: temperatureComboBox
					configKey: 'temperatureUnitId'
					model: WeatherPlugin.TemperatureUnitListModel

			}

		}
	}
    Item {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Note: 'wetter.com' server does not provide the current temperature, for this use other servers such as BBC")
    }
}
