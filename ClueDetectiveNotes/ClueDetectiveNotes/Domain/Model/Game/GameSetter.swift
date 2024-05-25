//
//  GameSetter.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

final class GameSetter {
    static let shared = GameSetter()
    
    private var sheet: Sheet
    private var setting = Setting()
    
    private init() { 
        self.sheet = Sheet(
            players: setting.getPlayers(),
            cards: setting.getEdition().cards
        )
    }
    
    func getSheet() -> Sheet {
        return sheet
    }
    
    func getPresentationSheet() -> PresentationSheet {
        return PresentationSheet(
            cells: sheet.getCellsImmutable(),
            mode: sheet.getMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
    
    func getSetting() -> Setting {
        return setting
    }
    
    func getPresentationSetting() -> PresentationSetting {
        return PresentationSetting(
            players: setting.getPlayers(),
            edition: setting.getEdition(),
            subMarkerTypes: setting.getSubMarkerTypes()
        )
    }
}
