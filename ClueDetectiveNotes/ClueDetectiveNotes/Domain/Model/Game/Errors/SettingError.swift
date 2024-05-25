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
    
    var errorDescription: String? {
        switch self {
        case .alreadyExistsSubMarkerType:
            return "The sub marker type already exists."
        case .invalidSubMarkerType:
            return "The sub marker type is invalid"
        }
    }
}
