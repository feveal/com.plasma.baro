import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.5 as Kirigami

import "../libweather" as LibWeather
import "../libconfig" as LibConfig

import QtQuick.Dialogs 1.2


GridLayout {
    columns: 2
    Layout.fillWidth: true
                Label {
                    text: i18n("Font Family:")
                }

            RowLayout {
                LibConfig.FontFamily {
                configKey: 'fontFamily'
                }
                LibConfig.TextFormat {
                boldConfigKey: 'bold'
                }
            }


                Label {
                    text: i18n("Forecast:")
                }
            LibConfig.SpinBox {
                Layout.columnSpan: 1
                configKey: "forecastFontSize"
                suffix: i18nc("font size suffix", "pt")
            }

                Label {
                    text: i18n("Temp:")
                }
            LibConfig.SpinBox {
                Layout.columnSpan: 1
                configKey: "tempFontSize"
                suffix: i18nc("font size suffix", "pt")
            }

                Label {
                    text: i18n("Details:")
                }
            LibConfig.SpinBox {
                Layout.columnSpan: 1
                configKey: "detailsFontSize"
                suffix: i18nc("font size suffix", "pt")
            }

                Label {
                    text: i18n("Text Color:")
                }
            LibConfig.ColorField {
                Layout.columnSpan: 1
                configKey: "textColor"
                defaultColor: PlasmaCore.Theme.textColor
            }

                Label {
                    text: i18n("Outline:")
                }
            RowLayout {
                Layout.columnSpan: 1
                Layout.fillWidth: true
                LibConfig.CheckBox {
                    id: showOutline
                    configKey: "showOutline"
                }
                LibConfig.ColorField {
                    Layout.columnSpan: 1
                    Layout.fillWidth: true
                    configKey: "outlineColor"
                    defaultColor: PlasmaCore.Theme.backgroundColor
                    enabled: showOutline.checked
                }
            }


}

