//
//  Cards.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

enum CardType: CustomStringConvertible {
    case suspect
    case weapon
    case room
    case none
    
    var description: String {
        switch self {
        case .suspect:
            return "용의자"
        case .weapon:
            return "무기"
        case .room:
            return "장소"
        case .none:
            return "빈값"
        }
    }
}

struct ClueCard: Hashable {
    let rawName: String
    let name: String
    let type: CardType
}

struct Cards {
    let suspects: [ClueCard]
    let weapons: [ClueCard]
    let rooms: [ClueCard]
    
    func allCards() -> [ClueCard] {
        return suspects + weapons + rooms
    }
    
    func allCardsCount() -> Int {
        return suspects.count + weapons.count + rooms.count
    }
    
    func getCards(type: CardType) -> [ClueCard] {
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
