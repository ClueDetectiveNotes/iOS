//
//  SwitchSingleModeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/12/24.
//

struct SwitchSingleModeUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ param: Int) -> PresentationSheet {
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension SwitchSingleModeUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
