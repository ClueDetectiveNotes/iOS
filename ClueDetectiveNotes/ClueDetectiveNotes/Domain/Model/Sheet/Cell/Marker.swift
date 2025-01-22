//
//  Marker.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/17.
//

protocol Markable {
    associatedtype markerType
    
    var notation: markerType { get set }
    var description: String { get }
}

struct MainMarker: Markable, Equatable {
    var notation: MainMarkerType
    var description: String {
        return notation.description
    }
}

struct SubMarker: Markable, Hashable {
    var notation: String
    var description: String {
        return notation
    }
}
