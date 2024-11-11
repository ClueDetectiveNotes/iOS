//
//  Snapshot.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/13/24.
//

import Foundation

struct Snapshot {
    private let mode: SheetMode
    private let selectedCellIds: [UUID]
    private let selectedRowNames: [CardType: RowName]
    private let selectedColName: ColName?
    private var mainMarkerMarkedCells = [(id: UUID, mainMarker: MainMarker)]()
    //private var subMarkerMarkedCells = [(id: UUID, subMarkers: Set<SubMarker>)]()
    private var subMarkerMarkedCells = [(id: UUID, subMarkers: [SubMarker])]()
    
    init() {
        let sheet = GameSetter.shared.getSheet()
        let cells = sheet.getCells()
        
        self.mode = sheet.getMode()
        
        self.selectedCellIds = sheet.getSelectedCells().map { cell in
            cell.getID()
        }
        
        self.selectedRowNames = sheet.getSelectedRowNames()
        self.selectedColName = sheet.getSelectedColName()
        
        cells.forEach { cell in
            if !cell.isEmptyMainMarker() {
                let id = cell.getID()
                let mainMarker = cell.getMainMarker()!
                self.mainMarkerMarkedCells.append((id, mainMarker))
            }
            if !cell.isEmptySubMarkers() {
                let id = cell.getID()
                let subMarkers = cell.getSubMarkers()
                self.subMarkerMarkedCells.append((id, subMarkers))
            }
        }
    }
    
    func getMode() -> SheetMode {
        return mode
    }
    
    func getSelectedCellIds() -> [UUID] {
        return selectedCellIds
    }
    
    func getSelectedRowNames() -> [CardType: RowName] {
        return selectedRowNames
    }
    
    func getSelectedColName() -> ColName? {
        return selectedColName
    }
    
    func getMainMarkerMarkedCells() -> [(id: UUID, mainMarker: MainMarker)] {
        return mainMarkerMarkedCells
    }
    
//    func getSubMarkerMarkedCells() -> [(id: UUID, subMarkers: Set<SubMarker>)] {
//        return subMarkerMarkedCells
//    }
    
    func getSubMarkerMarkedCells() -> [(id: UUID, subMarkers: [SubMarker])] {
        return subMarkerMarkedCells
    }
}
