//
//  Cards.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

enum CardType {
    case suspect
    case weapon
    case room
}

struct ClueCard: Hashable {
    let name: String
    let type: CardType
}

struct Cards {
    let suspects: [ClueCard]
    let weapon: [ClueCard]
    let room: [ClueCard]
    
    func allCards() -> [ClueCard] {
        return suspects + weapon + room
    }
}
