//
//  MainMarkerType.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

enum MainMarkerType: CaseIterable, CustomStringConvertible {
    case cross, check, question, exclamation, slash

    var description: String {
        switch self {
        case .cross:
            return "X"
        case .check:
            return "O"
        case .question:
            return "?"
        case .exclamation:
            return "!"
        case .slash:
            return "/"
        }
    }
}
