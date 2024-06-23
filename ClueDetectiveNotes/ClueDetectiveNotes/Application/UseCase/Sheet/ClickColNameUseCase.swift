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
    
    func execute(_ colName: ColName) throws -> PresentationSheet {
        switch sheet.getMode() {
        case .single, .multi:
            sheet.unselectCell()
            sheet.switchMode(.preInference)
            fallthrough
        case .preInference, .inference:
            if sheet.isSelectedColName(colName) {
                sheet.unselectColumnName()
            } else {
                sheet.unselectCell()
                _ = sheet.selectColumnName(colName)
            }
            try sheet.switchModeInInferenceMode()
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ClickColNameUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
