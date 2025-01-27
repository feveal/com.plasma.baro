import QtQuick 2.7
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore

GridLayout {
    id: dailyForecastView

    //--- Settings
    readonly property int dateFontSize: plasmoid.configuration.dateFontSize * PlasmaCore.Units.devicePixelRatio
    readonly property int minMaxFontSize: plasmoid.configuration.minMaxFontSize * PlasmaCore.Units.devicePixelRatio
    readonly property int showNumDays: plasmoid.configuration.showNumDays
    readonly property bool showDailyBackground: plasmoid.configuration.showDailyBackground
    readonly property bool showMinTempBelow: plasmoid.configuration.showMinTempBelow

    //---
    columnSpacing: PlasmaCore.Units.smallSpacing
    rowSpacing: PlasmaCore.Units.smallSpacing

    //--- Function to sanitize icon names
    function sanitizeIconName(iconName) {
        if (iconName.endsWith("-day")) {
            return iconName.slice(0, -4); // Remove "-day"
        } else if (iconName.endsWith("-night")) {
            return iconName.slice(0, -6); // Remove "-night"
        }
        return iconName; // Return unchanged if no suffix
    }

    // EnvCan has 2 day items for day/night, so we use 2 rows.
    readonly property int showNumDayItems: {
        if (weatherData.weatherSourceIsEnvcan) {
            if (weatherData.dataStartsWithNight) {
                return showNumDays * 2 - 1;
            } else {
                return showNumDays * 2;
            }
        } else {
            return showNumDays;
        }
    }
    rows: weatherData.weatherSourceIsEnvcan ? 2 : 1
    flow: GridLayout.TopToBottom

    //--- Layout
    property alias model: dayRepeater.model

    Item {
        id: placeholderDayItem
        visible: weatherData.dataStartsWithNight
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    Repeater {
        id: dayRepeater
        model: weatherData.dailyForecastModel

        Item {
            id: dayItem
            implicitWidth: dayItemLayout.implicitWidth + frame.margins.horizontal
            implicitHeight: dayItemLayout.implicitHeight + frame.margins.vertical
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 100 * parentContainer.scaleFactor
            Layout.alignment: Qt.AlignHCenter

            property alias dayItemIcon: dayItemIcon
            property alias frame: frame

            visible: {
                if (dailyForecastView.showNumDays == 0) { // Show all
                    return true;
                } else {
                    return (index + 1) <= dailyForecastView.showNumDayItems;
                }
            }

            PlasmaCore.FrameSvgItem {
                id: frame

                visible: dailyForecastView.showDailyBackground
                imagePath: visible ? "widgets/background" : ""
            }

            ColumnLayout {
                id: dayItemLayout

                WLabel {
                    Layout.minimumWidth: 80 * parentContainer.scaleFactor
                    text: modelData.dayLabel || ""

                    font.pixelSize: dailyForecastView.dateFontSize
                }

                PlasmaCore.IconItem {
                    Image {
                        id: dayItemIcon

                        width: 90 * parentContainer.scaleFactor
                        height: 70 * parentContainer.scaleFactor

                        // Apply sanitizeIconName here
                        source: "../images/" + dailyForecastView.sanitizeIconName(modelData.forecastIcon) + ".png"

                        Component.onCompleted: {
                            console.log("Sanitized icon source:", source);
                        }
                    }
                }

                GridLayout {
                    Layout.alignment: Qt.AlignHCenter
                    columnSpacing: PlasmaCore.Units.smallSpacing
                    rowSpacing: 0
                    flow: dailyForecastView.showMinTempBelow ? GridLayout.TopToBottom : GridLayout.LeftToRight

                    WLabel { text: "" }

                    WLabel {
                        readonly property var value: modelData.tempHigh
                        readonly property bool hasValue: !isNaN(value)
                        text: hasValue ? weatherData.formatTempShort(value) : ""
                        visible: hasValue
                        font.pixelSize: dailyForecastView.minMaxFontSize
                        Layout.alignment: Qt.AlignHCenter
                    }

                    WLabel {
                        readonly property var value: modelData.tempLow
                        readonly property bool hasValue: !isNaN(value)
                        text: hasValue ? weatherData.formatTempShort(value) : ""
                        visible: hasValue
                        font.pixelSize: dailyForecastView.minMaxFontSize
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }

            PlasmaCore.ToolTipArea {
                anchors.fill: parent
                mainText: modelData.forecastLabel
            }
        }
    }
}
