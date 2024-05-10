//
//  Cards.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

enum CardType: CaseIterable, CustomStringConvertible {
    case suspect
    case weapon
    case room
    
    var description: String {
        switch self {
        case .suspect:
            return "용의자"
        case .weapon:
            return "무기"
        case .room:
            return "장소"
        }
    }
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
