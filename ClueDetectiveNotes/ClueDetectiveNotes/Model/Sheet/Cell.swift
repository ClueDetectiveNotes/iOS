//
//  Cell.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

struct Cell: Identifiable, Hashable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String = UUID().uuidString
    let rowName: RowName
    let colName: ColName
    var markers: [Marker] = []
}

struct Marker: Hashable {
    let notation: String
}
