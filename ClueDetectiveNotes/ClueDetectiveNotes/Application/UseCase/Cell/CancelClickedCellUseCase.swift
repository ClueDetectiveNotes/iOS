//
//  CancelClickedCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct CancelClickedCellUseCase: UseCase {
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    func execute(_ param: Int) -> PresentationSheet {
        if sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        sheet.unselectCell()
        
        if sheet.hasSelectedColName() {
            sheet.unselectColumnName()
        }
        if sheet.hasSelectedRowName() {
            sheet.getSelectedRowNames().values.forEach { rowName in
                sheet.unselectRowName(rowName)
            }
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension CancelClickedCellUseCase {
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
