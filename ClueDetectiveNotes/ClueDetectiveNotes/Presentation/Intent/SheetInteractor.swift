//
//  SheetInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SheetInteractor {
    private var sheetStore: SheetStore
    private let sheetUseCase: SheetUseCase
    
    init(
        sheetStore: SheetStore,
        sheetUseCase: SheetUseCase = SheetUseCase()
    ) {
        self.sheetStore = sheetStore
        self.sheetUseCase = sheetUseCase
    }

    func clickCell(_ presentationCell: PresentationCell) {
        let presentationSheet = sheetUseCase.clickCell(presentationCell)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func longClickCell(_ presentationCell: PresentationCell) {
        let presentationSheet = sheetUseCase.longClickCell(presentationCell)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func clickColName(_ colName: ColName) {
        let presentationSheet = sheetUseCase.clickColName(colName)

        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func clickRowName(_ rowName: RowName) {
        let presentationSheet = sheetUseCase.clickRowName(rowName)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
}

// MARK: - Private
extension SheetInteractor {
    private func updateSheetStore(presentationSheet: PresentationSheet) {
        sheetStore.overwriteSheet(presentationSheet)
        
        if presentationSheet.hasSelectedCells() {
            sheetStore.setDisplayMarkerControlBar(true)
        } else {
            sheetStore.setDisplayMarkerControlBar(false)
        }
    }
}
