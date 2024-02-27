import QtQuick 2.9
import QtQuick.Layouts 1.3
import org.kde.plasma.core 2.0 as PlasmaCore

ColumnLayout {
	id: detailsView
	spacing: PlasmaCore.Units.smallSpacing

	property var model
	//--- Settings
	readonly property int detailsFontSize: plasmoid.configuration.detailsFontSize * PlasmaCore.Units.devicePixelRatio

	//--- Layout
	// The details grid code is from org.kde.plasma.weather

	GridLayout {
		Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

		rowSpacing: PlasmaCore.Units.smallSpacing

		Repeater {
			id: labelRepeater

			model: detailsView.model

			delegate: Loader {
				readonly property int rowIndex: index
				readonly property var rowData: modelData

/*
						Component.onCompleted: {
							console.log (rowIndex)
						}
*/
				Layout.minimumWidth: item.Layout.minimumWidth
				Layout.minimumHeight: item.Layout.minimumHeight
				Layout.alignment: item.Layout.alignment
				Layout.preferredWidth: item.Layout.preferredWidth
				Layout.preferredHeight: item.Layout.preferredHeight
				Layout.row: rowIndex
				Layout.column: 0

				sourceComponent: WLabel {
					Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
//					opacity: forecastLayout.fadedOpacity

					text: rowData.label

					font.pixelSize: detailsView.detailsFontSize
				}
			}
		}

		Repeater {
			id: repeater

			model: detailsView.model

			delegate: Loader {
				readonly property int rowIndex: index
				readonly property var rowData: modelData

				Layout.minimumWidth: item.Layout.minimumWidth
				Layout.minimumHeight: item.Layout.minimumHeight
				Layout.alignment: item.Layout.alignment
				Layout.preferredWidth: item.Layout.preferredWidth
				Layout.preferredHeight: item.Layout.preferredHeight
				Layout.row: rowIndex
				Layout.column: 1

				sourceComponent: WLabel {
					Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
					text: rowData.text
					font.pixelSize: detailsView.detailsFontSize
				}
			}
		}
	}

}
