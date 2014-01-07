import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "JSONListModel" as JSON
import "elements"

ListModel
{
    property string source: ""
    property string json: ""
    property string query: "$.element[*]"

    property string text: ""

}
