//
//  ChooseMainMarkerUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ChooseMainMarkerUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ marker: MainMarker) throws -> PresentationSheet {
        switch sheet.getMode() {
        case .single, .preInference:
            if let cell = sheet.getSelectedCells().first {
                if cell.equalsMainMarker(marker) {
                    cell.removeMainMarker()
                } else {
                    cell.setMainMarker(marker)
                }
            }
        case .multi:
            if sheet.isEveryCellMarkedWithMainMarker(),
               sheet.isSameMainMarkerInEveryCell(marker) {
                sheet.getSelectedCells().forEach { cell in
                    cell.removeMainMarker()
                }
            } else {
                sheet.getSelectedCells().forEach { cell in
                    cell.setMainMarker(marker)
                }
            }
        case .inference:
            let selectedCells = sheet.getSelectedCells()
            
            if sheet.isEveryCellMarkedWithMainMarker(),
               sheet.isSameMainMarkerInEveryCell(marker) {
                selectedCells.forEach { cell in
                    cell.removeMainMarker()
                }
            } else {
                selectedCells.forEach { cell in
                    cell.setMainMarker(marker)
                }
            }
            
            let currentColName = selectedCells[0].getColName()
            try selectNextInferenceCells(currentColName)
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ChooseMainMarkerUseCase {
    private func selectNextInferenceCells(_ currentColName: ColName) throws {
        // selectedCell, selectedColumnName 초기화
        sheet.unselectCell()
        sheet.unselectColumnName()
        
        // 다음 columnName 선택
        let nextColName = sheet.getNextColName(currentColName)
        _ = sheet.selectColumnName(nextColName)
        
        try sheet.switchModeInInferenceMode()
    }
    
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
