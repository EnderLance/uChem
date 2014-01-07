import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Components.Popups 0.1 as Popups
import Ubuntu.Components.Extras.Browser 0.1 as Browser
import "elements" as Elements
import "JSONListModel" as JSON
import "components"

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    objectName: "mainView"

    applicationName: "com.ubuntu.developer.enderlance.uChem"

    width: units.gu(50)
    height: units.gu(75)


    Component
    {
        id: popupInfo

        Popups.Dialog
        {
            id: popupInfoDialog

            title: "Info"
            text: "App by Brendan Wilson\n Contact: belancew@gmail.com"

            Button
            {
                id: loginButton

                text: "Go"
                color: "green"
                onClicked:
                {
                    PopupUtils.close(popupInfoDialog)
                }
            }
        }
    }

    ToolbarItems
    {
        id: toolbar
        ToolbarButton
        {
            id: infoButton
            text: i18n.tr("Info")

            iconSource: Qt.resolvedUrl("./icons/info.png")

            onTriggered:
            {
                PopupUtils.open(popupInfo)
            }
        }
    }

    PageStack
    {
        id: pageStack
        anchors.fill: parent
        Component.onCompleted: pageStack.push(uChemMainPage)

        Page {
            tools: toolbar

            id: uChemMainPage
            title: i18n.tr("uChem")

            Column {
                spacing: units.gu(1)
                anchors {
                    margins: units.gu(2)
                    fill: parent
                }

                Button {
                    objectName: "button"
                    width: parent.width

                    color: "green"

                    text: i18n.tr("Elements List")

                    onClicked: {
                        pageStack.push(uChemElementsList)
                    }
                }
            }
        }

        Page
        {
            id: uChemElementsList
            title: "Elements List"
            visible: false

            tools: toolbar

            Column
            {
                spacing: units.gu(1)
                anchors
                {
                    margins: units.gu(2)
                    fill: parent
                }

                TextField
                {
                    id: elementsSearchBox
                    width: parent.width
                    placeholderText: "Search"
                }

                ListView
                {
                    id: list15
                    width: parent.width
                    height: parent.height


                    JSON.JSONListModel
                    {
                        id: jsonModel15
                        source: "pte.txt"
                        query: "$.table[*]"
                    }

                    model: jsonModel15.model

                    delegate: Standard
                    {
                        text: model.name
                        progression: true
                        onClicked:
                        {
                            pageStack.push(elementPage)
                            currentElement.text = model.name
                        }
                    }
                }
            }
        }

        Page
        {
            id: elementPage

            title: currentElement.text
            visible: false

            tools: toolbar

            Column
            {
                spacing: units.gu(1)
                anchors
                {
                    margins: units.gu(2)
                    fill: parent
                }

                ListView
                {
                    id: elementInfoList

                    height: parent.height
                    width: parent.width

                    JSON.JSONListModel
                    {
                        id: elementListModel
                        source: "pte.txt"

                        query: "$.table."+currentElement.text+"[*]"

                    }

                    model: elementListModel.model

                    delegate: ElementInfoBox
                    {
                        height: parent.height
                        width: parent.width

                        symbol: model.symbol
                        protons: model.protons
                        neutrons: model.neutrons
                        wikipedia: model.link
                    }
                }

            }
        }

        Page
        {
            id: elementWikiPage

            visible: false
            tools: toolbar

            Column
            {
                anchors
                {
                    fill: parent

                }

                Browser.UbuntuWebView
                {
                    url: wikiLink.text
                    anchors.fill: parent

                    onLoadingChanged:
                    {
                        loadProgressBar.visible = loading
                    }

                    onLoadProgressChanged:
                    {
                        loadProgressBar.value = loadProgress
                    }
                }

                ProgressBar
                {
                    anchors.top: parent.bottom
                    id: loadProgressBar
                    height: units.gu(1)
                    width: parent.width
                    minimumValue: 0
                    maximumValue: 100
                }
            }
        }
    }

    Text
    {
        id: currentElement
        text: "Element"
        visible: false
    }

    Text
    {
        id: wikiLink
        text: "www.google.com"
        visible: false
    }
}
