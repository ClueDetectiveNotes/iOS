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
    
    func execute(_ presentationCell: PresentationCell) -> PresentationSheet {
        do {
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
                // user에게 모드 변경 안내
                print("preInference 모드에서 ClickCellUseCase가 실행됨")
                sheet.resetSelectedState()
            case .inference:
                // user에게 모드 변경 안내
                print("inference 모드에서 ClickCellUseCase가 실행됨")
                sheet.resetSelectedState()
            }
        } catch {
            switch error as? SheetError {
            case .inferenceModeException:
                print(SheetError.inferenceModeException.errorDescription ?? "")
            default:
                print(error.localizedDescription)
            }
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
