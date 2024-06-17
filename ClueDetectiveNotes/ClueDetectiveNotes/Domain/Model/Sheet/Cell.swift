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
    
    // MARK: - State
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
    
    // MARK: - GET
    func getID() -> UUID {
        return id
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
    
    // MARK: - SET
    func setMainMarker(_ marker: MainMarker) {
        mainMarker = marker
    }
    
    func setSubMarker(_ marker: SubMarker) {
        subMarkers.insert(marker)
    }
    
    func setSubMarkers(_ markers: Set<SubMarker>) {
        subMarkers = markers
    }
    
    func removeMainMarker() {
        mainMarker = nil
    }
    
    func removeSubMarker(_ marker: SubMarker) {
        subMarkers.remove(marker)
    }
    
    func removeSubMarkers() {
        subMarkers.removeAll()
    }
}

extension Cell: Hashable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
