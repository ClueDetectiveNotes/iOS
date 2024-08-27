//
//  InitSheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/24/24.
//

struct InitSheetUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ param: Int) throws -> PresentationSheet {
        let publicCards = GameSetter.shared.getSetting().getPublicCards()
        let myCards = GameSetter.shared.getSetting().getMyCards()
        
        sheet.getCells().forEach { cell in
            if cell.getColName().player is User {
                if myCards.contains(cell.getRowName().card) {
                    cell.setMainMarker(.init(notation: .check))
                } else {
                    cell.setMainMarker(.init(notation: .cross))
                }
                cell.setIsLock(true)
            } else {
                if publicCards.contains(cell.getRowName().card) {
                    cell.setMainMarker(.init(notation: .cross))
                    cell.setIsLock(true)
                }
            }
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension InitSheetUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}

