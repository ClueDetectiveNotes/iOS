//
//  Card.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

struct Card: Hashable {
    let owner: (any Player)?
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.owner?.id == rhs.owner?.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(owner?.id)
    }
}
