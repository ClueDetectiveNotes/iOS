//
//  ClickColNameUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ClickColNameUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ colName: ColName) -> PresentationSheet {
        do {
            switch sheet.getMode() {
            case .single, .multi:
                sheet.unselectCell()
                sheet.setMode(.preInference)
                fallthrough
            case .preInference, .inference:
                if sheet.isSelectedColName(colName) {
                    sheet.unselectColumnName()
                } else {
                    _ = sheet.selectColumnName(colName)
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
extension ClickColNameUseCase {
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
