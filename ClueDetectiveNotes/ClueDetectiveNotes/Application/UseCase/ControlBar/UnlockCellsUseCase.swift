//
//  UnlockCellsUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/27/24.
//

struct UnlockCellsUseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute() throws -> PresentationSheet {
        sheet.unlockCells()
        SnapshotManager.shared.unlockSnapshot()
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension UnlockCellsUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
