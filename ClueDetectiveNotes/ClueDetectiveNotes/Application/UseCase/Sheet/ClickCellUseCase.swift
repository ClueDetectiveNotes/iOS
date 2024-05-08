//
//  ClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

struct ClickCellUseCase {
    private var sheet: Sheet = GameSetter.shared.getSheetInstance()

    mutating func execute(cell: Cell) throws -> [String: Any] {
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.isSelectedCell(cell) {
                let selectedCells = try sheet.multiUnselectCell(cell)
                if selectedCells.isEmpty {
                    sheet.switchSelectionMode()
                }
                return createState(selectedCells)
            } else {
                return createState(sheet.selectCell(cell))
            }
        case false:
            if sheet.isSelectedCell(cell) {
                sheet.unselectCell()
                return createState(sheet.getSelectedCells())
            } else {
                sheet.unselectCell()
                return createState(sheet.selectCell(cell))
            }
        }
    }
    
    private func createState(_ selectedCells: [Cell]) -> [String: Any] {
        return ["selectedCells": selectedCells]
    }
}
