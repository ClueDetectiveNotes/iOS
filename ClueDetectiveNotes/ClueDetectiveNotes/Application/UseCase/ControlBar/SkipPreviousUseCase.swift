//
//  SkipPreviousUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/27/24.
//

struct SkipPreviousUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ parm: Int) throws -> PresentationSheet {
        if sheet.getMode() == .inference {
            let selectedCells = sheet.getSelectedCells()
            let currentColName = selectedCells[0].getColName()
            
            try selectPreviousInferenceCells(currentColName)
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension SkipPreviousUseCase {
    private func selectPreviousInferenceCells(_ currentColName: ColName) throws {
        // selectedCell, selectedColumnName 초기화
        sheet.unselectCell()
        sheet.unselectColumnName()
        
        // 다음 columnName 선택
        let previousColName = sheet.getPreviousColName(currentColName)
        _ = sheet.selectColumnName(previousColName)
        
        try sheet.switchModeInInferenceMode()
    }
    
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
