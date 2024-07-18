//
//  SettingError.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

import Foundation

enum SettingError: LocalizedError {
    case alreadyExistsSubMarkerType
    case invalidSubMarkerType
    case playerCountOutOfRange
    case alreadyExistsPlayer
    case nameIsEmpty
    case alreadySelectedCard
    
    var errorDescription: String? {
        switch self {
        case .alreadyExistsSubMarkerType:
            return "The sub marker type already exists."
        case .invalidSubMarkerType:
            return "The sub marker type is invalid."
        case .playerCountOutOfRange:
            return "Number of Player exceeds range."
        case .alreadyExistsPlayer:
            return "There already exists a player with the same name or ID."
        case .nameIsEmpty:
            return "An player name is empty."
        case .alreadySelectedCard:
            return "The card already is selected."
        }
    }
}
