import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
	id: nextForecastView

	opacity: weatherData.hasData ? 1 : 0

	//--- Layout
	Image {
		x:0 * parentContainer.scaleFactor
		y:150 * parentContainer.scaleFactor

		width: parent.ojectWidth
		height: parent.ojectHeight


		ColumnLayout {
			spacing: PlasmaCore.Units.smallSpacing

			DailyForecastView {
				id: dailyForecastView
			}

		}
	}
}
