//
//  PresentationSetting.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct PresentationSetting {
    let players: [Player]
    let edition: Edition
    let subMarkerTypes: [SubMarker]
    let publicCards: [Card]
    let myCards: [Card]
    
//    func getPlayersCountWithoutSolution() -> Int {
//        return players.filter { !($0 is Solution) }.count
//    }
    
//    func getPublicCardsCount() -> Int {
//        let cardsCount = edition.cards.allCardsCount()
//        let playerCount = getPlayersCountWithoutSolution()
//        
//        return (cardsCount - 3) % playerCount
//    }
//    
//    func getMyCardsCount() -> Int {
//        let cardsCount = edition.cards.allCardsCount()
//        let playerCount = getPlayersCountWithoutSolution()
//        
//        return (cardsCount - 3) / playerCount
//    }
}
