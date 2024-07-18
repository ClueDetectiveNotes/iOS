//
//  PresentationSetting.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct PresentationSetting {
    let players: [any Player]
    let edition: Edition
    let subMarkerTypes: [SubMarker]
    let publicCards: [ClueCard]
    
    func getPublicCardsCount() -> Int {
        let cardsCount = edition.cards.allCardsCount()
        let playerCount = getPlayersCountWithoutSolution()
        
        return (cardsCount - 3) % playerCount
    }
    
    func getPlayersCountWithoutSolution() -> Int {
        return players.filter { !($0 is Solution) }.count
    }
}
