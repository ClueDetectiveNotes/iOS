//
//  SubMarkerTypesError.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

import Foundation

enum SubMarkerTypesError: LocalizedError {
    case alreadyContainsSubMarker
    case notExistInSubMarker
    case subMarkerIsEmpty
    case remainingSingleSubMarker
    
    var errorDescription: String? {
        switch self {
        case .alreadyContainsSubMarker:
            return "That item is already contains sub marker items"
        case .notExistInSubMarker:
            return "That item does not exist in sub marker items"
        case .subMarkerIsEmpty:
            return "subMarker is empty."
        case .remainingSingleSubMarker:
            return "Only one sub-marker remains."
        }
    }
}
