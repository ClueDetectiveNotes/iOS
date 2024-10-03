//
//  PresentationGameSetting.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

import Foundation

struct PresentationGameSetting {
    let edition: Edition
    var players: [(id: UUID, name: String)]
    
    let playerCount: Int
    var playerNames: [String]
    
    let selectedPlayer: String
    let selectedPublicCards: [Card]
    let selectedMyCards: [Card]
    let publicCardsCount: Int
    let myCardsCount: Int
}

struct PresentationPlayer {
    let id: UUID
    let name: String
    let type: PlayerType
}
