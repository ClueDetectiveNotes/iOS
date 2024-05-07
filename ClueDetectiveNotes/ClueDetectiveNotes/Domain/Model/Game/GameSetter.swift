//
//  GameSetter.swift
//  ClueDetectiveNotes
//
//  Created by MARY on 5/7/24.
//

struct GameSetter {
    private var sheet: Sheet?
    private let setting: Setting
    
    mutating func getSheetInstance() -> Sheet {
        if let sheet {
            return sheet
        } else {
            let newSheet = Sheet(
                players: setting.players,
                cards: setting.edition.cards
            )
            sheet = newSheet
            return newSheet
        }
    }
}

struct Setting {
    var players: [Player]
    var edition: Edition
}
