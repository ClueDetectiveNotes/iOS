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
            cells: sheet.getCells(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCells(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
}

struct Setting {
    var players: [Player]
    var edition: Edition
    
    init(
        players: [Player] = [Player(name: "Player 1"), Player(name: "Player 2"), Player(name: "Player 3")],
        edition: Edition = .classic
    ) {
        self.players = players
        self.edition = edition
    }
}
