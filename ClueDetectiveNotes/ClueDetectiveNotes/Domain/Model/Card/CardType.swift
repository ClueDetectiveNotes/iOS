//
//  CardType.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
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
