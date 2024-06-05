//
//  LongClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct LongClickCellUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ presentationCell: PresentationCell) -> PresentationSheet {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        if !sheet.isMultiMode() {
            sheet.setMode(.multi)
        }
        
        if !sheet.isSelectedCell(cell) {
            _ = try! sheet.selectCell(cell)
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension LongClickCellUseCase {
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
