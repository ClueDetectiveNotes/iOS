//
//  SheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

struct SheetUseCase {
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    func clickCell(_ presentationCell: PresentationCell) -> PresentationSheet {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.hasSelectedColName() && sheet.hasSelectedRowName() {
                resetSelectedState()
            } else {
                
                if sheet.isSelectedCell(cell) {
                    _ = try! sheet.multiUnselectCell(cell)
                    if !sheet.hasSelectedCell() {
                        sheet.switchSelectionMode()
                    }
                } else {
                    _ = sheet.selectCell(cell)
                }
            }
        case false:
            if sheet.isSelectedCell(cell) {
                sheet.unselectCell()
            } else {
                sheet.unselectCell()
                _ = sheet.selectCell(cell)
            }
        }
        
        return createPresentationSheet()
    }
    
    func longClickCell(_ presentationCell: PresentationCell) -> PresentationSheet {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        if !sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        if !sheet.isSelectedCell(cell) {
            _ = sheet.selectCell(cell)
        }
        
        return createPresentationSheet()
    }
    
    func clickColName(_ colName: ColName) -> PresentationSheet {
        if sheet.isSelectedColName(colName) {
            sheet.unselectColumnName()
        } else {
            _ = sheet.selectColumnName(colName)
        }
        
        selectIntersectionCells()
        return createPresentationSheet()
    }
    
    func clickRowName(_ rowName: RowName) -> PresentationSheet {
        if sheet.isSelectedRowName(rowName) {
            sheet.unselectRowName(rowName)
        } else {
            _ = sheet.selectRowName(rowName)
        }
        
        selectIntersectionCells()
        return createPresentationSheet()
    }
    
    private func selectIntersectionCells() {
        if sheet.hasSelectedColName() && sheet.hasSelectedRowName() {
            let cells = try! sheet.getCellsIntersectionOfSelection()
            
            sheet.unselectCell()
            if !sheet.isMultiSelectionMode() {
                sheet.switchSelectionMode()
            }
            
            for cell in cells {
                _ = sheet.selectCell(cell)
            }
        }
    }
    
    private func resetSelectedState() {
        if sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        sheet.unselectCell()
        sheet.unselectColumnName()
        sheet.getSelectedRowNames().values.forEach { rowName in
            sheet.unselectRowName(rowName)
        }
    }
    
    private func createPresentationSheet() -> PresentationSheet {
        return PresentationSheet(
            cells: sheet.getCellsImmutable(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
}
