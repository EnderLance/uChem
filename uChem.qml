import QtQuick 2.0
import QtMultimedia 5.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Components.Popups 0.1 as Popups
import Ubuntu.Components.Extras.Browser 0.1 as Browser
import "JSONListModel" as JSON
import "components"
import "pages"

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    objectName: "uChem"

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
            text: "App by Brendan Wilson\nContact: belancew@gmail.com"

            Button
            {
                id: loginButton

                text: "Back"
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
                    id: elementListButton
                    objectName: "button"
                    width: parent.width

                    color: "green"

                    text: i18n.tr("Elements List")

                    onClicked: {
                        pageStack.push(uChemElementsList)
                    }
                }


                Button {
                    enabled: false
                    objectName: "button2"
                    width: parent.width
                    anchors.top: elementListButton.bottom

                    color: "green"

                    text: i18n.tr("Compound Maker")

                    onClicked: {
                        pageStack.push(compoundMakerPage)
                    }
                }

            }
        }

        Page {
            id: compoundMakerPage

            tools: toolbar
            width: units.gu(50)
            height: units.gu(75)

            anchors.fill: parent

            visible: false

            title: "Compound Maker"

            Column {

                width: parent.width
                height: parent.height
                spacing: units.gu(1)

                anchors {
                    fill: parent
                    margins: units.gu(2)
                }

                ListView {
                    id: compoundSelectionList
                    height: parent.height
                    width: parent.width

                    JSON.JSONListModel {
                        id: jsonList1
                        source: "pte.txt"
                        query: "$.table[*]"
                    }

                    model: jsonList1.model

                    section.property: "metal"

                    delegate: SingleValue {
                        text: model.name
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
                id: listColumn
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
                        source: "pte.json"
                        query: "$.table[*]"
                    }

                    model: jsonModel15.model

                    delegate: Subtitled
                    {

                        id: delegate
                        text: model.Element
                        subText: model.AtomicNumber
                        progression: true
                        onClicked:
                        {
                            elementPage.dataNumber = (model.AtomicNumber - 1)
                            print("Atomic number is: "+model.AtomicNumber)
                            print("elementPage's dataNumber is "+elementPage.dataNumber)
                            pageStack.push(elementPage)
                            print("elementPage's dataNumber is "+elementPage.dataNumber)
                            currentElement.text = model.Element
                        }
                    }
                }
            }
        }

        Page
        {
            id: elementPage

            title: currentElement.text

            property int dataNumber;

            visible: false

            tools: toolbar

            anchors.fill: parent

                ListView
                {
                    anchors.fill: parent

                    id: elementInfoList

                    height: parent.height
                    width: parent.width

                    JSON.JSONListModel
                    {
                        id: elementListModel
                        source: "pte.json"

                        query: "$.table["+elementPage.dataNumber+"]"

                    }

                    model: elementListModel.model

                    delegate: ElementInfoBox {
                        height: parent.height
                        width: parent.width

                        name: model.Element
                        symbol: model.Symbol
                        number: model.AtomicNumber
                        density: model.Density
                        category: model.Category
                        weight: model.AtomicWeight
                        //wikipedia: "https://en.m.wikipedia.org/wiki/"+(model.Element.toString).toLowerCase
                    }
                }
        }

        /*
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
        */

        Page
        {
            id: elementImage

            title: currentElement.text+" Image"
            height: parent.height
            width: parent.width
            visible: false

            Image
            {
                scale: 2
                id: image
                anchors.centerIn: parent
                source: "elements/"+(currentElement.text).toLowerCase()+".jpg"
            }

        }
    }



    Text
    {
        id: currentElement
        text: "Element"
        visible: false
    }

    /*
    Text
    {
        id: wikiLink
        text: "www.google.com"
        visible: false
    }
    */
}

