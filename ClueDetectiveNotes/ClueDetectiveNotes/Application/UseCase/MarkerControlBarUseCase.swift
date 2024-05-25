//
//  MarkerControlBarUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

struct MarkerControlBarUseCase {
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    func chooseMainMarker(_ marker: MainMarker) -> PresentationSheet {
        switch sheet.isMultiSelectionMode() {
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
    
    func chooseSubMarker(_ marker: SubMarker) -> PresentationSheet {
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.isEveryCellMarkedWithSameSubMarker(marker) {
                sheet.getSelectedCells().forEach { cell in
                    cell.removeSubMarker(marker)
                }
            } else {
                sheet.getSelectedCells().forEach { cell in
                    if !cell.containsSubMarker(marker) {
                        cell.setSubMarker(marker)
                    }
                }
            }
        case false:
            if let cell = sheet.getSelectedCells().first {
                if cell.containsSubMarker(marker) {
                    cell.removeSubMarker(marker)
                } else {
                    cell.setSubMarker(marker)
                }
            }
        }
        
        return createPresentationSheet()
    }
    
    func clickCancelButton() -> PresentationSheet {
        if sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        sheet.unselectCell()
        
        if sheet.hasSelectedColName() {
            sheet.unselectColumnName()
        }
        if sheet.hasSelectedRowName() {
            sheet.getSelectedRowNames().values.forEach { rowName in
                sheet.unselectRowName(rowName)
            }
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension MarkerControlBarUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return PresentationSheet(
            cells: sheet.getCellsImmutable(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
}
