//
//  SnapshotError.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/13/24.
//

import Foundation

enum SnapshotError: LocalizedError {
    case snapshotStackIsEmpty
    
    var errorDescription: String? {
        switch self {
        case .snapshotStackIsEmpty:
            return "Snapshot does not exist"
        }
    }
}
