//
//  Marker.swift
//  ClueDetectiveNotes
//
//  Created by MARY on 2024/04/17.
//

protocol Markerable {
    associatedtype markerType
    
    var notation: markerType { get set }
}

struct SubMarker: Markerable {
    var notation: String
}

struct MainMarker: Markerable {
    var notation: MainMarkerType
}

enum MainMarkerType: CustomStringConvertible {
    case x, o, question, exclamation, slash

    var description: String {
        switch self {
        case .x:
            return "X"
        case .o:
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
