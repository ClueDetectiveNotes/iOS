//
//  LongClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct LongClickCellUseCase: UseCase {
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    func execute(_ presentationCell: PresentationCell) -> PresentationSheet {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        if !sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        if !sheet.isSelectedCell(cell) {
            _ = sheet.selectCell(cell)
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension LongClickCellUseCase {
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
