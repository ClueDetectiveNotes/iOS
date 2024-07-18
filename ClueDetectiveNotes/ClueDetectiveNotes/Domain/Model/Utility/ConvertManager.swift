//
//  ConvertManager.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/13/24.
//

struct ConvertManager {
    static func getImmutableCells(_ mutableCells: [Cell]) -> [PresentationCell] {
        return mutableCells.map { cell in
            PresentationCell(
                id: cell.getID(),
                rowName: cell.getRowName(),
                colName: cell.getColName(),
                mainMarker: cell.getMainMarker(),
                subMarkers: cell.getSubMarkers().sorted { $0.notation < $1.notation }
            )
        }
    }
    
    static func getImmutableSheet(_ mutableSheet: Sheet) -> PresentationSheet {
        return PresentationSheet(
            cells: getImmutableCells(mutableSheet.getCells()),
            mode: mutableSheet.getMode(),
            rowNames: mutableSheet.getRowNames(),
            colNames: mutableSheet.getColNames(),
            selectedCells: getImmutableCells(mutableSheet.getSelectedCells()),
            selectedRowNames: mutableSheet.getSelectedRowNames(),
            selectedColName: mutableSheet.getSelectedColName()
        )
    }
    
    static func getImmutableSetting(_ mutableSetting: Setting) -> PresentationSetting {
        return PresentationSetting(
            players: mutableSetting.getPlayers(),
            edition: mutableSetting.getEdition(),
            subMarkerTypes: mutableSetting.getSubMarkerTypes(),
            publicCards: mutableSetting.getPublicCards()
        )
    }
}
