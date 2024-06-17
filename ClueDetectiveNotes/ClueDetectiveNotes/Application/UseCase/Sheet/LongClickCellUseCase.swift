//
//  LongClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct LongClickCellUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ presentationCell: PresentationCell) throws -> PresentationSheet {
        let cell = try sheet.findCell(id: presentationCell.id)
        
        switch sheet.getMode() {
        case .single:
            sheet.switchMode(.multi)
            fallthrough
        case .multi:
            if sheet.isSelectedCell(cell) {
                // 이미 선택된 cell를 longClick하더라도 아무런 처리를 하지 않음
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
extension LongClickCellUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
