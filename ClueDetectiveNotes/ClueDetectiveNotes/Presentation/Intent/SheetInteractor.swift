//
//  SheetInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SheetInteractor {
    private var sheetStore: SheetStore
    private let clickCellUseCase: ClickCellUseCase
    private let longClickCellUseCase: LongClickCellUseCase
    private let clickColNameUseCase: ClickColNameUseCase
    private let clickRowNameUseCase: ClickRowNameUseCase
    
    init(
        sheetStore: SheetStore,
        clickCellUseCase: ClickCellUseCase = ClickCellUseCase(),
        longClickCellUseCase: LongClickCellUseCase = LongClickCellUseCase(),
        clickColNameUseCase: ClickColNameUseCase = ClickColNameUseCase(),
        clickRowNameUseCase: ClickRowNameUseCase = ClickRowNameUseCase()
    ) {
        self.sheetStore = sheetStore
        self.clickCellUseCase = clickCellUseCase
        self.longClickCellUseCase = longClickCellUseCase
        self.clickColNameUseCase = clickColNameUseCase
        self.clickRowNameUseCase = clickRowNameUseCase
    }

    func clickCell(_ presentationCell: PresentationCell) {
        let presentationSheet = clickCellUseCase.execute(presentationCell)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func longClickCell(_ presentationCell: PresentationCell) {
        let presentationSheet = longClickCellUseCase.execute(presentationCell)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func clickColName(_ colName: ColName) {
        let presentationSheet = clickColNameUseCase.execute(colName)

        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func clickRowName(_ rowName: RowName) {
        let presentationSheet = clickRowNameUseCase.execute(rowName)
        
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
