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
            return "SUSPECT"
        case .weapon:
            return "WEAPON"
        case .room:
            return "CRIME_SCENE"
        case .none:
            return "NONE"
        }
    }
}
