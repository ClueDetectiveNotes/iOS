//
//  ClickRowNameUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ClickRowNameUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ rowName: RowName) -> PresentationSheet {
        if sheet.isSelectedRowName(rowName) {
            sheet.unselectRowName(rowName)
        } else {
            _ = sheet.selectRowName(rowName)
        }

        selectIntersectionCells()
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ClickRowNameUseCase {
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
