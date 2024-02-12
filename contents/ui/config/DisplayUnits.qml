// Version 1

import QtQuick 2.0

QtObject {
	id: displayUnits

	// https://doc.qt.io/qt-5/qml-qtqml-locale.html#measurementSystem-prop
	readonly property bool localeUsesMetric: Qt.locale().measurementSystem == Locale.MetricSystem

	//---
	readonly property int locale_temperatureUnitId: {
		if (localeUsesMetric) {
			return 6001 // Celsius
		} else {
			return 6002 // Fahrenheit
		}
	}
	readonly property int locale_windSpeedUnitId: {
		if (localeUsesMetric) {
			return 9000 // MeterPerSecond
		} else {
			return 9002 // MilePerHour
		}
	}
	readonly property int locale_pressureUnitId: {
		if (localeUsesMetric) {
			return 5008 // Hectopascal
		} else {
			return 5028 // InchesOfMercury
		}
	}
	readonly property int locale_visibilityUnitId: {
		if (localeUsesMetric) {
			return 2007 // Kilometer
		} else {
			return 2024 // Mile
		}
	}

	//---
	readonly property int temperatureUnitId: {
		if (plasmoid.configuration.temperatureUnitId === 0) { // Use locale default
			return locale_temperatureUnitId
		} else {
			return plasmoid.configuration.temperatureUnitId
		}
	}

	//---
	function setDisplayUnit(key, nextValue) {
		// console.log('setDisplayUnit', key, nextValue)
		var localeUnitId = displayUnits['locale_' + key + 'UnitId']
		var configUnitId = plasmoid.configuration[key + 'UnitId']
		// console.log('\t', 'localeUnitId', localeUnitId)
		// console.log('\t', 'configUnitId', configUnitId)

		if (localeUnitId === nextValue) {
			if (configUnitId != 0) {
				// console.log('\t\t', 'config', key + 'UnitId', 0)
				plasmoid.configuration[key + 'UnitId'] = 0
			}
		} else if (configUnitId === nextValue) {
			return
		} else { // configUnitId !== nextValue
			// console.log('\t\t', 'config', key + 'UnitId', nextValue)
			plasmoid.configuration[key + 'UnitId'] = nextValue
		}
	}
	function setTemperatureUnitId(nextValue) {
		setDisplayUnit('temperature', nextValue)
	}

}
