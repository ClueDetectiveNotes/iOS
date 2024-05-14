//
//  SheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

import Foundation

struct SheetUseCase {
    private var sheetStore: SheetStore
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
    }
    
    func loadCell(_ cell: PresentationCell) -> PresentationCell {
        do {
            return try sheetStore.sheet.findCell(id: cell.id)
        } catch {
            return cell
        }
    }
    
    func clickCell(_ presentationCell: PresentationCell) {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.isSelectedCell(cell) {
                _ = try! sheet.multiUnselectCell(cell)
                if !sheet.hasSelectedCell() {
                    sheet.switchSelectionMode()
                    sheetStore.setDisplayMarkerControlBar(false)
                } else {
                    sheetStore.setDisplayMarkerControlBar(true)
                }
            } else {
                _ = sheet.selectCell(cell)
            }
        case false:
            if sheet.isSelectedCell(cell) {
                sheet.unselectCell()
                sheetStore.setDisplayMarkerControlBar(false)
            } else {
                sheet.unselectCell()
                _ = sheet.selectCell(cell)
                sheetStore.setDisplayMarkerControlBar(true)
            }
        }
        
        updatePresentationSheet()
    }
    
    func longClickCell(_ presentationCell: PresentationCell) {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        if !sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        if sheet.isSelectedCell(cell) {
            sheetStore.setDisplayMarkerControlBar(false)
        } else {
            _ = sheet.selectCell(cell)
            sheetStore.setDisplayMarkerControlBar(true)
        }
        
        updatePresentationSheet()
    }
    
    private func updatePresentationSheet() {
        let presentationSheet = PresentationSheet(
            cells: sheet.getCellsImmutable(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
        
        sheetStore.overwriteSheet(presentationSheet)
    }
}
