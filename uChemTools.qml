import QtQuick 2.0
import Ubuntu.Components 0.1

ToolbarItems
{
    ToolbarButton
    {
        id: infoButton
        text: i18n.tr("Info")

        onTriggered:
        {
            PopupUtils.open(popupInfo)
        }
    }
}
