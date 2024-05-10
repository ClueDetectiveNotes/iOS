//
//  ClickCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

struct ClickCellUseCase {
    private let sheet: Sheet = GameSetter.shared.getSheetInstance()
    private let store: SheetStore
    
    init(store: SheetStore) {
        self.store = store
    }
    
    func execute(cell: Cell) throws {
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.isSelectedCell(cell) {
                let selectedCells = try sheet.multiUnselectCell(cell)
                if selectedCells.isEmpty {
                    sheet.switchSelectionMode()
                    store.isDisplayMarkerControlBar = false
                } else {
                    store.isDisplayMarkerControlBar = true
                }
            } else {
                _ = sheet.selectCell(cell)
            }
        case false:
            if sheet.isSelectedCell(cell) {
                sheet.unselectCell()
                store.isDisplayMarkerControlBar = false
            } else {
                sheet.unselectCell()
                _ = sheet.selectCell(cell)
                store.isDisplayMarkerControlBar = true
            }
        }
        
        store.sampleSheet = sheet
    }
    
    private func createState(_ selectedCells: [Cell]) -> [String: Any] {
        return ["selectedCells": selectedCells]
    }
}
