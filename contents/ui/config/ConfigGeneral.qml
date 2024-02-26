import QtQuick 2.0
import QtQuick.Controls 2.0 as QQC2
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.5 as Kirigami

import "../libweather" as LibWeather
import "../libconfig" as LibConfig

Kirigami.FormLayout {
	Layout.fillWidth: true

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

	LibConfig.CheckBox {
		id: showDetails
		configKey: "showDetails"
		text: i18n("Show weather details")
	}

	RowLayout {
		Item {
			implicitWidth: Kirigami.Units.largeSpacing * 2
		}
		LibConfig.CheckBox {
			configKey: "showWarnings"
			text: i18n("Show weather warnings")
			enabled: showDetails.checked
		}
	}

	LibConfig.CheckBox {
		configKey: "showBackground"
		text: i18n("Desktop Widget: Show background")
	}

    Item {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: i18n("Note: 'wetter.com' server does not provide the current temperature, for this use other servers such as BBC")
    }

}
