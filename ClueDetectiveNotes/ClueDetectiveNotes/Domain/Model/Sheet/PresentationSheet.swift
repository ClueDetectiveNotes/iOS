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
    
    func isSelectedCell(_ cell: PresentationCell) -> Bool {
        return selectedCells.contains(cell)
    }
    
    func findCell(id: UUID) throws -> PresentationCell {
        if let cell = cells.filter({ $0.id == id }).first {
            return cell
        } else {
            throw SheetError.cellNotFound
        }
    }
    
    func isSelectedRowName(_ rowName: RowName) -> Bool {
        return selectedRowNames.values.contains(rowName)
    }
    
    func isSelectedColName(_ colName: ColName) -> Bool {
        return selectedColName == colName
    }
}
