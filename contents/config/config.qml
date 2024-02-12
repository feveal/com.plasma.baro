import QtQuick 2.1
import org.kde.plasma.configuration 2.0
import org.kde.plasma.private.weather 1.0 as WeatherPlugin

ConfigModel {
     ConfigCategory {
		name: i18n("Weather Baro")
		icon: Qt.resolvedUrl('../screenshot.png').replace('file://', '')
		source: "config/ConfigGeneral.qml"
	}
     ConfigCategory {
        name: i18nc("@title", "Font Appearance")
        icon: "preferences-desktop-color"
        source: "config/ConfigAppearance.qml"
    }
}
