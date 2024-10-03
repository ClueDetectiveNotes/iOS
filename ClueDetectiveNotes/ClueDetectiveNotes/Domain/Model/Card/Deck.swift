//
//  Cards.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

struct Deck {
    let suspects: [Card]
    let weapons: [Card]
    let rooms: [Card]
    
    func allCards() -> [Card] {
        return suspects + weapons + rooms
    }
    
    func allCardsCount() -> Int {
        return suspects.count + weapons.count + rooms.count
    }
    
    func getCards(type: CardType) -> [Card] {
        switch type {
        case .suspect:
            return suspects
        case .weapon:
            return weapons
        case .room:
            return rooms
        default:
            return []
        }
    }
}
