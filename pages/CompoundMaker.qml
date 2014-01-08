import QtQuick 2.0
import QtQuick 2.0
import QtMultimedia 5.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Components.Popups 0.1 as Popups
import "../JSONListModel" as JSON
import "../components"

Page {
    id: compoundMakerPage

    width: units.gu(50)
    height: units.gu(75)

    UbuntuShape {
        id: uShape
        height: units.gu(20)
        width: parent.width

        Label {
            id: uShapeLabel
            text: ""
        }
    }


}
