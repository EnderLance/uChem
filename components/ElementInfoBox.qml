import QtQuick 2.0
import QtMultimedia 5.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem


Item
{
    id: shape

    property string wikipedia: ""
    property string name;
    property string symbol;
    property string density;
    property string weight;
    property string category;
    property int number;

    ListItem.SingleValue
    {
        id: symbolSlot
        text: "Symbol: "+symbol
    }

    ListItem.SingleValue
    {
        anchors.top: symbolSlot.bottom
        id: numberSlot
        text: "Atomic Number: "+number
    }

    ListItem.SingleValue
    {
        anchors.top: numberSlot.bottom
        id: categorySlot
        text: "Category: "+category
    }

    ListItem.SingleValue
    {
        anchors.top: categorySlot.bottom
        id: densitySlot
        text: "Density: "+density
    }

    ListItem.SingleValue
    {
        anchors.top: densitySlot.bottom
        id: weightSlot
        text: "Atomic Weight: "+weight.toString()
    }

    /*
    ListItem.Standard
    {
        anchors.top: weightSlot.bottom
        id: linkSlot
        progression: true
        text:"More info: "+wikipedia
        onClicked:
        {
            pageStack.push(elementWikiPage)
        }
    }
    */

    ListItem.Standard
    {
        anchors.top: weightSlot.bottom
        id: imageSlot
        progression: true
        text: "Image"
        onClicked:
        {
            currentElement.text = name
            pageStack.push(elementImage)
        }
    }
}
