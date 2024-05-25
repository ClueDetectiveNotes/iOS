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
        
        switch sheet.isMultiMode() {
        case true:
            if sheet.hasSelectedColName() && sheet.hasSelectedRowName() {
                resetSelectedState()
            } else {
                if sheet.isSelectedCell(cell) {
                    _ = try! sheet.multiUnselectCell(cell)
                    if !sheet.hasSelectedCell() {
                        sheet.setMode(.single)
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
        if sheet.isMultiMode() {
            sheet.setMode(.single)
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
            mode: sheet.getMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
}
