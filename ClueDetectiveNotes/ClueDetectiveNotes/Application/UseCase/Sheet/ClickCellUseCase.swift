//
//  ClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ClickCellUseCase: UseCase {
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    func execute(_ presentationCell: PresentationCell) -> PresentationSheet {
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
}

// MARK: - Private
extension ClickCellUseCase {
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
