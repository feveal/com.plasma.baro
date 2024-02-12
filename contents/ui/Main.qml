import QtQuick 2.3
import QtQuick.Layouts 1.0
import org.kde.plasma.components 3.0
import org.kde.plasma.plasmoid 2.0

import "baro"
import "./libweather" as LibWeather

Item {
    id: parentContainer

        anchors.fill: parent
        property double scaleFactor: Math.min(width / mainWidth, height / mainHeight)

        Baro {
            id: baro;
            z: 10
            anchors.fill: parent
        }

    readonly property bool debug: false

    readonly property int mainWidth: 478 //540
    readonly property int mainHeight: 478

    state: plasmoid.configuration.mainState

    width: mainWidth
    height: mainHeight

    Layout.preferredWidth: mainWidth
    Layout.preferredHeight: mainHeight

    Plasmoid.backgroundHints: "NoBackground"

//----------------

    LibWeather.WeatherData {
        id: weatherData
    }

	Plasmoid.toolTipMainText: weatherData.currentConditions

		property Item contentItem: weatherData.needsConfiguring ? configureButton : forecastLayout

		ForecastLayout {
			id: forecastLayout
			visible: !weatherData.needsConfiguring
		}


	function action_refresh() {
		weatherData.refresh()
	}

	Component.onCompleted: {
		plasmoid.setAction("refresh", i18n("Refresh"), "view-refresh")

	}

}
