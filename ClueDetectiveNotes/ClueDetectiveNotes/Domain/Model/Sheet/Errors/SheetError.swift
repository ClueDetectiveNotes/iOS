//
//  SheetError.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/15.
//

import Foundation

enum SheetError: LocalizedError {
    case cellNotFound
    case notMultiSelectionMode
    case cannotSelectAlreadySelectedCell
    case cannotUnselectNeverChosenCell
    case notYetSelectAnyRowName
    case notYetSelectAnyColumnName
    
    var errorDescription: String? {
        switch self {
        case .cellNotFound:
            return "Can not find that cell in cells"
        case .notMultiSelectionMode:
            return "Current selection mode is not multi selection mode"
        case .cannotSelectAlreadySelectedCell:
            return "Can not select already selected cell"
        case .cannotUnselectNeverChosenCell:
            return "Can not unselect never chosen cell"
        case .notYetSelectAnyRowName:
            return "Not yet select any row name"
        case .notYetSelectAnyColumnName:
            return "Not yet select any column name"
        }
    }
}