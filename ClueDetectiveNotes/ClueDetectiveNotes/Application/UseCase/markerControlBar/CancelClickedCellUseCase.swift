//
//  CancelClickedCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/8/24.
//

struct CancelClickedCellUseCase {
    private var sheet = GameSetter.shared.getSheetInstance()
    
    mutating func execute() throws {
        if sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        sheet.unselectCell()
    }
}
