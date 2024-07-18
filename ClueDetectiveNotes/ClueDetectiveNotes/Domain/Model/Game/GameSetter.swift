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
        //return DummySetting.setting
    }
}

struct DummyPlayers {
    static let players: [any Player] = [
        User(id: 1, name: "코코"),
        Other(id: 2, name: "다산"),
        Other(id: 3, name: "메리"),
        Other(id: 4, name: "야곰"),
        Other(id: 5, name: "가가"),
        Other(id: 6, name: "나나"),
        Solution(id: 10000, name: "정답")
    ]
}

struct DummySetting {
    static let setting: Setting = Setting(
        players: DummyPlayers.players,
        edition: .classic,
        subMarkerTypes: [
            SubMarker(notation: "1"),
            SubMarker(notation: "2"),
            SubMarker(notation: "3"),
            SubMarker(notation: "4")
        ],
        publicCards: []
    )
}
