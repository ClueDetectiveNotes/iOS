//
//  DoubleClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 12/17/24.
//

struct DoubleClickCellUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ presentationCell: PresentationCell) throws -> PresentationSheet {
        let cell = try sheet.findCell(id: presentationCell.id)
        
        sheet.unselectCell()
        _ = try sheet.selectCell(cell)
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension DoubleClickCellUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
