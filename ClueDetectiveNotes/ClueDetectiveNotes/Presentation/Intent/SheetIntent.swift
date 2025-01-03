//
//  SheetIntent.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SheetIntent {
    private var sheetStore: SheetStore
    private var initSheetUseCase: InitSheetUseCase
    private let clickCellUseCase: AnyUseCase<PresentationCell>
    private let longClickCellUseCase: AnyUseCase<PresentationCell>
    private let clickColNameUseCase: AnyUseCase<ColName>
    private let clickRowNameUseCase: AnyUseCase<RowName>
    
    init(
        sheetStore: SheetStore,
        initSheetUseCase: InitSheetUseCase = InitSheetUseCase(),
        clickCellUseCase: AnyUseCase<PresentationCell> = AnyUseCase(SnapshotDecorator(ClickCellUseCase())),
        longClickCellUseCase: AnyUseCase<PresentationCell> = AnyUseCase(SnapshotDecorator(LongClickCellUseCase())),
        clickColNameUseCase: AnyUseCase<ColName> = AnyUseCase(SnapshotDecorator(ClickColNameUseCase())),
        clickRowNameUseCase: AnyUseCase<RowName> = AnyUseCase(SnapshotDecorator(ClickRowNameUseCase()))
    ) {
        self.sheetStore = sheetStore
        self.initSheetUseCase = initSheetUseCase
        self.clickCellUseCase = clickCellUseCase
        self.longClickCellUseCase = longClickCellUseCase
        self.clickColNameUseCase = clickColNameUseCase
        self.clickRowNameUseCase = clickRowNameUseCase
    }
    
    func initSheet() {
        do {
            let presentationSheet = try initSheetUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }

    func clickCell(_ presentationCell: PresentationCell) {
        do {
            let presentationSheet = try clickCellUseCase.execute(presentationCell)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func longClickCell(_ presentationCell: PresentationCell) {
        do {
            let presentationSheet = try longClickCellUseCase.execute(presentationCell)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickColName(_ colName: ColName) {
        do {
            let presentationSheet = try clickColNameUseCase.execute(colName)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickRowName(_ rowName: RowName) {
        do {
            let presentationSheet = try clickRowNameUseCase.execute(rowName)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
}

// MARK: - Private
extension SheetIntent {
    private func updateSheetStore(presentationSheet: PresentationSheet) {
        sheetStore.overwriteSheet(presentationSheet)
        
        if presentationSheet.hasSelectedCells() {
            sheetStore.setIsShowingMarkerControlBar(true)
        } else {
            sheetStore.setIsShowingMarkerControlBar(false)
        }
    }
}
