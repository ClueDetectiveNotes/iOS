//
//  SheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

struct SheetUseCase {
    private var sheetStore: SheetStore
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
    }
    
    func clickCell(_ cell: Cell) {
        switch sheetStore.sheet.isMultiSelectionMode() {
        case true:
            if sheetStore.sheet.isSelectedCell(cell) {
                _ = try! sheetStore.sheet.multiUnselectCell(cell)
                if !sheetStore.sheet.hasSelectedCell() {
                    sheetStore.sheet.switchSelectionMode()
                    sheetStore.isDisplayMarkerControlBar = false
                } else {
                    sheetStore.isDisplayMarkerControlBar = true
                }
            } else {
                _ = sheetStore.sheet.selectCell(cell)
            }
        case false:
            if sheetStore.sheet.isSelectedCell(cell) {
                sheetStore.sheet.unselectCell()
                sheetStore.isDisplayMarkerControlBar = false
            } else {
                sheetStore.sheet.unselectCell()
                _ = sheetStore.sheet.selectCell(cell)
                sheetStore.isDisplayMarkerControlBar = true
            }
        }
    }
    
    func longClickCell(_ cell: Cell) {
        if !sheetStore.sheet.isMultiSelectionMode() {
            sheetStore.sheet.switchSelectionMode()
        }
        
        if sheetStore.sheet.isSelectedCell(cell) {
            sheetStore.isDisplayMarkerControlBar = false
        } else {
            _ = sheetStore.sheet.selectCell(cell)
            sheetStore.isDisplayMarkerControlBar = true
        }
    }
}
