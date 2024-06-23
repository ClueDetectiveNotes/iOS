//
//  GameSetter.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

final class GameSetter {
    static let shared = GameSetter()
    
    private var sheet: Sheet?
    private var setting = Setting()
    
    private init() { }
    
    func getSheet() -> Sheet {
        if let sheet {
            return sheet
        } else {
            let newSheet = Sheet(
                players: setting.getPlayers(),
                cards: setting.getEdition().cards
            )
            self.sheet = newSheet
            return newSheet
        }
    }
    
    func getSetting() -> Setting {
        return setting
    }
}
