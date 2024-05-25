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
    
    func execute(_ marker: MainMarker) -> PresentationSheet {
        switch sheet.isMultiMode() {
        case true:
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
        case false:
            if let cell = sheet.getSelectedCells().first {
                if cell.equalsMainMarker(marker) {
                    cell.removeMainMarker()
                } else {
                    cell.setMainMarker(marker)
                }
            }
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ChooseMainMarkerUseCase {
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
