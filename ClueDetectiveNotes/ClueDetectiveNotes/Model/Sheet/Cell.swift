//
//  Cell.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

final class Cell {
    private let rowName: RowName
    private let colName: ColName
    private var mainMarker: MainMarker?
    private var subMarkers = Set<SubMarker>()
    
    init(
        rowName: RowName,
        colName: ColName
    ) {
        self.rowName = rowName
        self.colName = colName
    }
    
    func getRowName() -> RowName {
        return rowName
    }
    
    func getColName() -> ColName {
        return colName
    }
    
    func getMainMarker() -> MainMarker? {
        return mainMarker
    }
    
    func getSubMarkers() -> Set<SubMarker> {
        return subMarkers
    }
    
    func setMainMarker(_ marker: MainMarker) {
        if mainMarker == marker {
            mainMarker = nil
        } else {
            mainMarker = marker
        }
    }
    
    func setSubMarker(_ marker: SubMarker) {
        if subMarkers.contains(marker) {
            subMarkers.remove(marker)
        } else {
            subMarkers.insert(marker)
        }
    }
}

extension Cell: Hashable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.rowName == rhs.rowName && lhs.colName == rhs.colName
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(rowName)
        hasher.combine(colName)
    }
}
