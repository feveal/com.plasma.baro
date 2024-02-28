import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
	id: nextForecastView

	opacity: weatherData.hasData ? 1 : 0

	states: [
            State {
                name: "clicked"
                PropertyChanges {
                    target: nextForecastView
                    scale: 0.01
                    x: 70 * parentContainer.scaleFactor
                    y: 30 * parentContainer.scaleFactor

                }
            }
        ]

	transitions: [
        Transition {
            from: "clicked"; to: "*"
            NumberAnimation { properties: "scale"; duration: 1000 } //InOutBack
            NumberAnimation { properties: "x, y "; duration: 700 }
        },
        Transition {
            from: "*"; to: "clicked"
            NumberAnimation { properties: "scale"; duration: 1000 }
            NumberAnimation { properties: "x, y "; duration: 700 }
        }
    ]
	//--- Layout
	Image {
		id: nextImages
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
