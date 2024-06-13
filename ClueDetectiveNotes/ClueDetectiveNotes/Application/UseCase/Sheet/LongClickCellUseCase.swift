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
    
    func execute(_ presentationCell: PresentationCell) -> PresentationSheet {
        do {
            let cell = try sheet.findCell(id: presentationCell.id)
            
            switch sheet.getMode() {
            case .single:
                sheet.setMode(.multi)
                fallthrough
            case .multi:
                if sheet.isSelectedCell(cell) {
                    // 이미 선택된 cell를 longClick하더라도 아무런 처리를 하지 않음
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
extension LongClickCellUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
