//
//  Marker.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/17.
//

protocol Markable {
    associatedtype markerType
    
    var notation: markerType { get set }
}

struct MainMarker: Markable, Equatable {
    var notation: MainMarkerType
}

struct SubMarker: Markable, Hashable {
    var notation: String
}
