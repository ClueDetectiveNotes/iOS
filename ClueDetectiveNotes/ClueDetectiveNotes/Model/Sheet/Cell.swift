//
//  Cell.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

struct Cell: Identifiable {
    let id = UUID()
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
    
    mutating func setMainMarker(_ marker: MainMarker) {
        if mainMarker == marker {
            mainMarker = nil
        } else {
            mainMarker = marker
        }
    }
    
    mutating func setSubMarker(_ marker: SubMarker) {
        if subMarkers.contains(marker) {
            subMarkers.remove(marker)
        } else {
            subMarkers.insert(marker)
        }
    }
}
