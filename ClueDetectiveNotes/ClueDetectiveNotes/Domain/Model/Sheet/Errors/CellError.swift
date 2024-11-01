//
//  CellError.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

import Foundation

enum CellError: LocalizedError {
    case alreadyContainsSubMarker
    case notExistInSubMarker
    case subMarkerIsEmpty
    
    var errorDescription: String? {
        switch self {
        case .alreadyContainsSubMarker:
            return "That item is already contains sub marker items"
        case .notExistInSubMarker:
            return "That item does not exist in sub marker items"
        case .subMarkerIsEmpty:
            return "subMarker is empty."
        }
    }
}
