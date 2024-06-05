//
//  ClickColNameUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ClickColNameUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ colName: ColName) -> PresentationSheet {
        if sheet.isSelectedColName(colName) {
            sheet.unselectColumnName()
        } else {
            _ = sheet.selectColumnName(colName)
        }

        selectIntersectionCells()
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ClickColNameUseCase {
    private func selectIntersectionCells() {
        if sheet.hasSelectedColName() && sheet.hasSelectedRowName() {
            let cells = try! sheet.getCellsIntersectionOfSelection()

            sheet.unselectCell()
            if !sheet.isMultiMode() {
                sheet.setMode(.multi)
            }

            for cell in cells {
                _ = try! sheet.selectCell(cell)
            }
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
