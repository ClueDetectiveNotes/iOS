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
    private var isLock: Bool = false
    
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
    
    func isLocked() -> Bool {
        return isLock
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
        if !isLock {
            mainMarker = marker
        }
    }
    
    func setSubMarker(_ marker: SubMarker) {
        if !isLock {
            subMarkers.insert(marker)
        }
    }
    
    func setSubMarkers(_ markers: Set<SubMarker>) {
        if !isLock {
            subMarkers = markers
        }
    }
    
    func removeMainMarker() {
        if !isLock {
            mainMarker = nil
        }
    }
    
    func removeSubMarker(_ marker: SubMarker) {
        if !isLock {
            subMarkers.remove(marker)
        }
    }
    
    func removeSubMarkers() {
        if !isLock {
            subMarkers.removeAll()
        }
    }
    
    func setIsLock(_ isLock: Bool) {
        self.isLock = isLock
    }
    
    func lock() {
        if self.mainMarker?.notation == .cross ||
            self.mainMarker?.notation == .check {
            self.isLock = true
        }
    }
    
    func unlock() {
        self.isLock = false
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
