//
//  SheetMode.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

enum SheetMode: CustomStringConvertible {
    case single, multi, inference, preInference
    
    var description: String {
        switch self {
        case .single:
            return "single"
        case .multi:
            return "multi"
        case .inference:
            return "inference"
        case .preInference:
            return "preInference"
        }
    }
}
