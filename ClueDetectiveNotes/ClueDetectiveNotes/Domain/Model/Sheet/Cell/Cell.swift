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
    private var isInit: Bool = false
    
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
    
    func isInited() -> Bool {
        return isInit
    }
    
    func isAnswer() -> Bool {
        return !(self.colName.cardHolder is Player)
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
    
    func getIsLock() -> Bool {
        return isLock
    }
    
    // MARK: - SET
    func setMainMarker(_ marker: MainMarker) {
        if !isLock && !isInit {
            mainMarker = marker
        }
    }
    
    func setSubMarker(_ marker: SubMarker) {
        if !isLock && !isInit {
            subMarkers.insert(marker)
        }
    }
    
    func setSubMarkers(_ markers: Set<SubMarker>) {
        if !isLock && !isInit {
            subMarkers = markers
        }
    }
    
    func removeMainMarker() {
        if !isLock && !isInit {
            mainMarker = nil
        }
    }
    
    func removeSubMarker(_ marker: SubMarker) {
        if !isLock && !isInit {
            subMarkers.remove(marker)
        }
    }
    
    func removeSubMarkers() {
        if !isLock && !isInit {
            subMarkers.removeAll()
        }
    }
    
    func setIsLock(_ isLock: Bool) {
        self.isLock = isLock
    }
    
    func setIsInit(_ isInit: Bool) {
        self.isInit = isInit
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
