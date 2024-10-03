//
//  CardHolder.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/17/24.
//

import Foundation

//protocol CardHoldable: Hashable {
//    var id: UUID { get }
//    var name: String { get set }
//    var cards: [Card] { get set }
//}

class CardHolder {
    let id: UUID
    var name: String
    var cards: [Card]
    
    init(
        name: String,
        cards: [Card] = []
    ) {
        self.id = UUID()
        self.name = name
        self.cards = cards
    }
    
    func takeCard(_ card: Card) {
        cards.append(card)
    }
    
    func removeCard(_ card: Card) {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
        }
    }
    
    func removeAllCard() {
        cards.removeAll()
    }
    
    func hasCard(_ card: Card) -> Bool {
        return cards.contains(card)
    }
    
    func setCards(_ cards: [Card]) {
        self.cards = cards
    }
}
