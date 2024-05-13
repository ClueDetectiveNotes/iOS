//
//  MarkerControlBarUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

struct MarkerControlBarUseCase {
    private var sheetStore: SheetStore
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
    }
    
    func chooseMainMarker(marker: MainMarker) {
        switch sheetStore.sheet.isMultiSelectionMode() {
        case true:
            if sheetStore.sheet.isEveryCellMarkedWithMainMarker(),
               sheetStore.sheet.isSameMainMarkerInEveryCell(marker) {
                sheetStore.sheet.getSelectedCells().forEach { cell in
                    cell.removeMainMarker()
                }
            } else {
                sheetStore.sheet.getSelectedCells().forEach { cell in
                    cell.setMainMarker(marker)
                }
            }
        case false:
            guard let cell = sheetStore.sheet.getSelectedCells().first else { return }
            
            if cell.equalsMainMarker(marker) {
                cell.removeMainMarker()
            } else {
                cell.setMainMarker(marker)
            }
        }
        sheetStore.isDisplayMarkerControlBar = false
    }
    
    func cancelClickedCell() {
        if sheetStore.sheet.isMultiSelectionMode() {
            sheetStore.sheet.switchSelectionMode()
        }
        sheetStore.sheet.unselectCell()
    }
}
