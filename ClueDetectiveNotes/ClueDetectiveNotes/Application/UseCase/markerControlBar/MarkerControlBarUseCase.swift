//
//  MarkerControlBarUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

struct MarkerControlBarUseCase {
    private var sheetStore: SheetStore
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
    }
    
    func chooseMainMarker(marker: MainMarker) {
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
            guard let cell = sheet.getSelectedCells().first else { return }
            
            if cell.equalsMainMarker(marker) {
                cell.removeMainMarker()
            } else {
                cell.setMainMarker(marker)
            }
        }
        sheetStore.setDisplayMarkerControlBar(false)
        updatePresentationSheet()
    }
    
    func chooseSubMarker(marker: SubMarker) {
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
            guard let cell = sheet.getSelectedCells().first else { return }
            
            if cell.containsSubMarker(marker) {
                cell.removeSubMarker(marker)
            } else {
                cell.setSubMarker(marker)
            }
        }
        sheetStore.setDisplayMarkerControlBar(false)
        updatePresentationSheet()
    }
    
    func cancelClickedCell() {
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
        
        sheetStore.setDisplayMarkerControlBar(false)
        updatePresentationSheet()
    }
    
    private func resetSelectedState() {
        if sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        sheet.unselectCell()
        sheet.unselectColumnName()
        sheet.getSelectedRowNames().values.forEach { rowName in
            sheet.unselectRowName(rowName)
        }
    }
    
    private func updatePresentationSheet() {
        let presentationSheet = PresentationSheet(
            cells: sheet.getCellsImmutable(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
        
        sheetStore.overwriteSheet(presentationSheet)
    }
}
