//
//  SheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

struct SheetUseCase {
    private var sheetStore: SheetStore
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
    }
    
    func clickCell(_ cell: Cell) {
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.isSelectedCell(cell) {
                _ = try! sheet.multiUnselectCell(cell)
                if !sheet.hasSelectedCell() {
                    sheet.switchSelectionMode()
                    sheetStore.isDisplayMarkerControlBar = false
                } else {
                    sheetStore.isDisplayMarkerControlBar = true
                }
            } else {
                _ = sheet.selectCell(cell)
            }
        case false:
            if sheet.isSelectedCell(cell) {
                sheet.unselectCell()
                sheetStore.isDisplayMarkerControlBar = false
            } else {
                sheet.unselectCell()
                _ = sheet.selectCell(cell)
                sheetStore.isDisplayMarkerControlBar = true
            }
        }
        
        updatePresentationSheet()
    }
    
    func longClickCell(_ cell: Cell) {
        if !sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        if sheet.isSelectedCell(cell) {
            sheetStore.isDisplayMarkerControlBar = false
        } else {
            _ = sheet.selectCell(cell)
            sheetStore.isDisplayMarkerControlBar = true
        }
        
        updatePresentationSheet()
    }
    
    private func updatePresentationSheet() {
        sheetStore.sheet = PresentationSheet(
            cells: sheet.getCells(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCells(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
}
