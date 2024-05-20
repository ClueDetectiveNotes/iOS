//
//  PresentationSheet.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/14/24.
//

import Foundation

struct PresentationSheet {
    let cells: [PresentationCell]
    let isMultiMode: Bool
    let rowNames: [RowName]
    let colNames: [ColName]
    let selectedCells: [PresentationCell]
    let selectedRowNames: [CardType: RowName]
    let selectedColName: ColName?
    
    func hasSelectedCells() -> Bool {
        return !selectedCells.isEmpty
    }
    
    func isSelectedCell(_ cell: PresentationCell) -> Bool {
        return selectedCells.contains(cell)
    }
    
    func findCell(id: UUID) -> PresentationCell? {
        return cells.filter({ $0.id == id }).first
    }
    
    func isSelectedRowName(_ rowName: RowName) -> Bool {
        return selectedRowNames.values.contains(rowName)
    }
    
    func isSelectedColName(_ colName: ColName) -> Bool {
        return selectedColName == colName
    }
}
