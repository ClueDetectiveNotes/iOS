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
            players: setting.players,
            cards: setting.edition.cards
        )
    }
    
    func getSheet() -> Sheet {
        return sheet
    }
    
    func getPresentationSheet() -> PresentationSheet {
        return PresentationSheet(
            cells: sheet.getCellsImmutable(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
    
    func getSubMarkerTypes() -> [SubMarker] {
        return setting.subMarkerTypes
    }
}

struct Setting {
    var players: [Player]
    var edition: Edition
    var subMarkerTypes: [SubMarker]
    
    init(
        players: [Player] = [Player(name: "Player 1"), Player(name: "Player 2"), Player(name: "Player 3")],
        edition: Edition = .classic,
        subMarkerTypes: [SubMarker] = [SubMarker(notation: "1"), SubMarker(notation: "2"), SubMarker(notation: "3"), SubMarker(notation: "4"),
                                       SubMarker(notation: "메"), SubMarker(notation: "다"), SubMarker(notation: "코"), SubMarker(notation: "A")]
    ) {
        self.players = players
        self.edition = edition
        self.subMarkerTypes = subMarkerTypes
    }
}
