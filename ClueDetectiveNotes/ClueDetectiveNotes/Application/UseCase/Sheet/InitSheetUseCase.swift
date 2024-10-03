//
//  InitSheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/24/24.
//

struct InitSheetUseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute() throws -> PresentationSheet {
        let publicCards = GameSetter.shared.getGame().getPublicOne().cards
        let myCards = GameSetter.shared.getGame().getUser()?.cards ?? []
        
        sheet.getCells().forEach { cell in
            if cell.getColName().cardHolder is User {
                if myCards.contains(cell.getRowName().card) {
                    cell.setMainMarker(.init(notation: .check))
                } else {
                    cell.setMainMarker(.init(notation: .cross))
                }
                cell.setIsLock(true)
            } else {
                if myCards.contains(cell.getRowName().card) {
                    cell.setMainMarker(.init(notation: .cross))
                }
                if publicCards.contains(cell.getRowName().card) {
                    cell.setMainMarker(.init(notation: .cross))
                }
                cell.setIsLock(true)
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
