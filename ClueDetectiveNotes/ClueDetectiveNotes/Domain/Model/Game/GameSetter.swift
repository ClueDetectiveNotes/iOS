//
//  GameSetter.swift
//  ClueDetectiveNotes
//
//  Created by MARY on 5/7/24.
//

final class GameSetter {
    static let shared = GameSetter()
    
    private var sheet: Sheet?
    private var setting = Setting()
    
    private init() { }
    
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
    
    init(
        players: [Player] = [Player(name: "Player 1"), Player(name: "Player 2"), Player(name: "Player 3")],
        edition: Edition = .classic
    ) {
        self.players = players
        self.edition = edition
    }
}
