//
//  ClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ClickCellUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ presentationCell: PresentationCell) throws -> PresentationSheet {
        let cell = try sheet.findCell(id: presentationCell.id)
        
        switch sheet.getMode() {
        case .single:
            if sheet.isSelectedCell(cell) {
                sheet.unselectCell()
            } else {
                sheet.unselectCell()
                _ = try sheet.selectCell(cell)
            }
        case .multi:
            if sheet.isSelectedCell(cell) {
                _ = try sheet.multiUnselectCell(cell)
                sheet.switchModeInSelectionMode()
            } else {
                _ = try sheet.multiSelectCell(cell)
            }
        case .preInference:
            sheet.resetSelectedState()
            print("preInference 모드에서 ClickCellUseCase가 실행됨")
            //throw SheetError.inferenceModeException
        case .inference:
            sheet.resetSelectedState()
            print("inference 모드에서 ClickCellUseCase가 실행됨")
            //throw SheetError.inferenceModeException
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ClickCellUseCase {    
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
