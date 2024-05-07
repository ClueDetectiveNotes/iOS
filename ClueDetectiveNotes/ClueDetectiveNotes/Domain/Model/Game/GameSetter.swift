//
//  GameSetter.swift
//  ClueDetectiveNotes
//
//  Created by MARY on 5/7/24.
//

final class GameSetter {
    private var sheet: Sheet?
    private let setting: Setting
    
    init(setting: Setting) {
        self.setting = setting
    }
    
    func getSheetInstance() -> Sheet {
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
