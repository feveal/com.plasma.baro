import QtQuick 2.3
import QtQuick.Layouts 1.0
import org.kde.plasma.components 3.0
import org.kde.plasma.plasmoid 2.0
import QtQuick.XmlListModel 2.0

import "baro"
import "moon"
import "./libweather" as LibWeather

Item {
    id: parentContainer

        anchors.fill: parent
        property double scaleFactor: Math.min(width / mainWidth, height / mainHeight)

        Baro {
            id: baro;
            z: 1
            anchors.fill: parent
        }

        Moon {
            id: moon
            z: 2
            scale: 0.5
            //-----------

            property var moonData: XmlListModel {
                source: "http://iohelix.net/moon/moonlite.xml"
                query: "/data/moon"
                XmlRole {
                    name: "elongationToSun"
                    query: "elongationToSun/string()"
                }
                XmlRole {
                    name: "phase"
                    query: "phase/string()"
                }
                XmlRole {
                    name: "percentIlluminated"
                    query: "percentIlluminated/string()"
                }
                XmlRole {
                    name: "nextphase"
                    query: "nextPhase/phase/string()"
                }
                XmlRole {
                    name: "daysToPhase"
                    query: "nextPhase/daysToPhase/string()"
                }
            }


            property var elongSun: undefined
            property var percentIlu: undefined
            property var moonPhase: undefined
            property var daysPhase: undefined
            property var nextPhase: undefined

            Component.onCompleted: {
                moonData.statusChanged.connect(function() {
                    if (moonData.status === XmlListModel.Ready) {
                        elongSun = moonData.get(0).elongationToSun
                        percentIlu = moonData.get(0).percentIlluminated
                        moonPhase = moonData.get(0).phase
                        daysPhase = moonData.get(0).daysToPhase
                        nextPhase = moonData.get(0).nextphase
//                        console.log(">>: ", elongSun + " - " + percentIlu + " - " + moonPhase + " - " + daysPhase + nextPhase)
                    }

                })
            }

        }

    readonly property bool debug: false

    readonly property int mainWidth: 478 //540
    readonly property int mainHeight: 478

//    state: plasmoid.configuration.mainState

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
