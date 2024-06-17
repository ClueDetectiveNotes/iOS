//
//  Snapshot.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/13/24.
//

import Foundation

struct Snapshot {
    //private var sheet: Sheet // GameSetter에서 sheet를 들고오기 때문에, 스냅샵이 스냅샷이 될 수 없음ㅠㅠ 계속 최신의 Sheet 값을 가지고있게됨
    private let mode: SheetMode
    private let selectedCellIds: [UUID]
    private let selectedRowNames: [CardType: RowName]
    private let selectedColName: ColName?
    private var mainMarkerMarkedCells = [(UUID, MainMarker)]()
    private var subMarkerMarkedCells = [(UUID, Set<SubMarker>)]()
    
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
    
    func getMainMarkerMarkedCells() -> [(UUID, MainMarker)] {
        return mainMarkerMarkedCells
    }
    
    func getSubMarkerMarkedCells() -> [(UUID, Set<SubMarker>)] {
        return subMarkerMarkedCells
    }
}
