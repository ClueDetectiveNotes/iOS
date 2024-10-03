//
//  GameError.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 9/18/24.
//

import Foundation

enum GameError: LocalizedError {
    case notFoundUser
    case notFoundGame
    
    var errorDescription: String? {
        switch self {
        case .notFoundUser:
            return "User not found."
        case .notFoundGame:
            return "Game not found."
        }
    }
}
