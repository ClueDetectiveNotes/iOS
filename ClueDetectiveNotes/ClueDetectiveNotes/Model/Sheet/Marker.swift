//
//  Marker.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/17.
//

protocol Markerable {
    associatedtype markerType
    
    var notation: markerType { get set }
}

struct SubMarker: Markerable, Hashable {
    var notation: String
}

struct MainMarker: Markerable, Equatable {
    var notation: MainMarkerType
}

enum MainMarkerType: CustomStringConvertible {
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
