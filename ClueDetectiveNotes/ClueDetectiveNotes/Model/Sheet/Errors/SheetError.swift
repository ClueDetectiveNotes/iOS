//
//  SheetError.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 2024/04/15.
//

import Foundation

enum SheetError: LocalizedError {
    case cellNotFound
    case notMultiSelectionMode
    
    var errorDescription: String? {
        switch self {
        case .cellNotFound:
            return "Can not find that cell in cells"
        case .notMultiSelectionMode:
            return "Current selection mode is not multi selection mode"
        }
    }
}
