//
//  Cell.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

final class Cell {
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
    
    func setMainMarker(_ marker: MainMarker) {
        mainMarker = marker
    }
    
    func setSubMarker(_ marker: SubMarker) throws {
        guard !subMarkers.contains(marker) else {
            throw CellError.alreadyContainsSubMarker
        }
        subMarkers.insert(marker)
    }
    
    func removeMainMarker() {
        mainMarker = nil
    }
    
    func removeSubMarker(_ marker: SubMarker) throws {
        guard subMarkers.contains(marker) else {
            throw CellError.notExistInSubMarker
        }
        subMarkers.remove(marker)
    }
}

extension Cell: Equatable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.id == rhs.id
    }
}
