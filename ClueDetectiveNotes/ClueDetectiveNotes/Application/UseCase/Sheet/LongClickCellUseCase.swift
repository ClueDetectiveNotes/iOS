//
//  LongClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

struct LongClickCellUseCase {
    private var sheet: Sheet
    
    init(gameSetter: GameSetter) {
        sheet = gameSetter.getSheetInstance()
    }
    
    mutating func execute(cell: Cell) -> [String: Any] {
        if !sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        return createState(
            sheet.isMultiSelectionMode(),
            sheet.selectCell(cell)
        )
    }
    
    private func createState(
        _ isMultiSelectionMode: Bool,
        _ selectedCells: [Cell]
    ) -> [String: Any] {
        return [
            "isMultiSelectionMode": isMultiSelectionMode,
            "selectedCells": selectedCells
        ]
    }
}
