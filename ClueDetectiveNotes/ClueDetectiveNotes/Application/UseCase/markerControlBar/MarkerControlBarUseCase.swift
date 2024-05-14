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
        sheetStore.isDisplayMarkerControlBar = false
        
        //updatePresentationSheet()
    }
    
    func cancelClickedCell() {
        if sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        sheet.unselectCell()
        
        //updatePresentationSheet()
    }
    
    private func updatePresentationSheet() {
        sheetStore.sheet = PresentationSheet(
            cells: sheet.getCells(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCells(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
    }
}
