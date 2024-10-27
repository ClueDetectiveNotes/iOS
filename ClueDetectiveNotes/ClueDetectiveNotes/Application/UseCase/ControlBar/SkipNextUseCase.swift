//
//  SkipNextUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/27/24.
//

struct SkipNextUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ parm: Int) throws -> PresentationSheet {
        if sheet.getMode() == .inference {
            let selectedCells = sheet.getSelectedCells()
            let currentColName = selectedCells[0].getColName()
            
            try selectNextInferenceCells(currentColName)
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension SkipNextUseCase {
    private func selectNextInferenceCells(_ currentColName: ColName) throws {
        // selectedCell, selectedColumnName 초기화
        sheet.unselectCell()
        sheet.unselectColumnName()
        
        // 다음 columnName 선택
        let nextColName = sheet.getNextColName(currentColName)
        _ = sheet.selectColumnName(nextColName)
        
        try sheet.switchModeInInferenceMode()
    }
    
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
