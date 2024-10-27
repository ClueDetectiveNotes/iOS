//
//  LockCellsUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/27/24.
//

struct LockCellsUseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute() throws -> PresentationSheet {
        sheet.lockCells()
        SnapshotManager.shared.lockSnapshot()
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension LockCellsUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
