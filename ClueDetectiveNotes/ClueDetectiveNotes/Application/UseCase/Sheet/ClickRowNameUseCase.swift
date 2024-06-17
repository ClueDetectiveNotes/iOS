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
    
    func execute(_ rowName: RowName) throws -> PresentationSheet {
        switch sheet.getMode() {
        case .single, .multi:
            sheet.unselectCell()
            sheet.switchMode(.preInference)
            fallthrough
        case .preInference, .inference:
            if sheet.isSelectedRowName(rowName) {
                sheet.unselectRowName(rowName)
            } else {
                _ = sheet.selectRowName(rowName)
            }
            try sheet.switchModeInInferenceMode()
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ClickRowNameUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
