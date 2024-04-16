import QtQuick 2.0
import QtQuick.XmlListModel 2.0

Item {
    id: moonComponent

    property alias moonData: moonXmlListModel
    property var elongSun: undefined
    property var percentIlu: undefined
    property var moonPhase: undefined
    property var daysPhase: undefined
    property var nextPhase: undefined

    XmlListModel {
        id: moonXmlListModel
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

    Component.onCompleted: {
        moonXmlListModel.statusChanged.connect(function() {
            if (moonXmlListModel.status === XmlListModel.Ready) {
                elongSun = moonXmlListModel.get(0).elongationToSun
                percentIlu = moonXmlListModel.get(0).percentIlluminated
                moonPhase = moonXmlListModel.get(0).phase
                daysPhase = moonXmlListModel.get(0).daysToPhase
                nextPhase = moonXmlListModel.get(0).nextphase
//                console.log(">>: ", elongSun + " - " + percentIlu + " - " + moonPhase + " - " + daysPhase + nextPhase)
            }
        })
    }

    function refresh() {
        // Desconecta la fuente de datos actual
        moonData.source = ""
        // Vuelve a conectar la fuente de datos
        moonData.source = "http://iohelix.net/moon/moonlite.xml"
    }

}
