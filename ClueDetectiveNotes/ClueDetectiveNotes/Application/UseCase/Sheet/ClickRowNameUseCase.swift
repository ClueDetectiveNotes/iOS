//
//  ClickRowNameUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ClickRowNameUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ rowName: RowName) -> PresentationSheet {
        do {
            switch sheet.getMode() {
            case .single, .multi:
                sheet.unselectCell()
                sheet.setMode(.preInference)
                fallthrough
            case .preInference, .inference:
                if sheet.isSelectedRowName(rowName) {
                    sheet.unselectRowName(rowName)
                } else {
                    _ = sheet.selectRowName(rowName)
                }
                try sheet.switchModeInInferenceMode()
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ClickRowNameUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return PresentationSheet(
            cells: sheet.getCellsImmutable(),
            mode: sheet.getMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
}
