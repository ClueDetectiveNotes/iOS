//
//  Cell.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

struct Cell {
    private let id = UUID()
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
    
    func isEmptyMainMarker() -> Bool {
        return mainMarker == nil
    }
    
    func isEmptySubMarkers() -> Bool {
        return subMarkers.isEmpty
    }
    
    func containsSubMarker(_ marker: SubMarker) -> Bool {
        return subMarkers.contains(marker)
    }
    
    func equalsMainMarker(_ marker: MainMarker) -> Bool {
        return mainMarker == marker
    }
    
    mutating func setMainMarker(_ marker: MainMarker) {
        mainMarker = marker
    }
    
    mutating func setSubMarker(_ marker: SubMarker) throws {
        guard !subMarkers.contains(marker) else {
            throw CellError.alreadyContainsSubMarker
        }
        subMarkers.insert(marker)
    }
    
    mutating func removeMainMarker() {
        mainMarker = nil
    }
    
    mutating func removeSubMarker(_ marker: SubMarker) throws {
        guard !subMarkers.contains(marker) else {
            throw CellError.alreadyContainsSubMarker
        }
        subMarkers.remove(marker)
    }
}

extension Cell: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
