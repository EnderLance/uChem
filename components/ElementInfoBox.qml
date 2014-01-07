import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem


UbuntuShape
{
    height: units.gu(75)
    width: units.gu(30)

    property string name: ""
    property string symbol: ""
    property int protons: 0
    property int neutrons: 0
    property string wikipedia: ""

    ListItem.SingleValue
    {
        anchors.top: nameSlot.bottom
        id: symbolSlot
        text: "Symbol: "+symbol
    }

    ListItem.SingleValue
    {
        anchors.top: symbolSlot.bottom
        id: protonsSlot
        text: "Protons: "+protons
    }

    ListItem.SingleValue
    {
        anchors.top: protonsSlot.bottom
        id: neutronsSlot
        text: "Neutrons: "+neutrons
    }

    ListItem.Standard
    {
        anchors.top: neutronsSlot.bottom
        id: linkSlot
        progression: true
        text:"More info: "+wikipedia
        onClicked:
        {
            wikiLink.text = wikipedia
            pageStack.push(elementWikiPage)
        }
    }
}
