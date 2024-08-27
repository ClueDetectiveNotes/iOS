//
//  ControlBarInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

struct ControlBarInteractor {
    private var sheetStore: SheetStore
    private let undoUseCase: UndoUseCase
    private let redoUseCase: RedoUseCase
    private let clearUseCase: AnyUseCase<Int>
    private let cancelUseCase: AnyUseCase<Int>
    
    init(
        sheetStore: SheetStore,
        undoUseCase: UndoUseCase = UndoUseCase(),
        redoUseCase: RedoUseCase = RedoUseCase(),
        clearUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(ClearMarkerSelectedCellUseCase())),
        cancelUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(CancelClickedCellUseCase()))
    ) {
        self.sheetStore = sheetStore
        self.undoUseCase = undoUseCase
        self.redoUseCase = redoUseCase
        self.clearUseCase = clearUseCase
        self.cancelUseCase = cancelUseCase
    }
    
    func clickUndo() {
        do {
            let presentationSheet = try undoUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickRedo() {
        do {
            let presentationSheet = try redoUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickClearButton() {
        do {
            let presentationSheet = try clearUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickVisibleButton() {
        sheetStore.isVisibleScreen.toggle()
    }
    
    func clickCancelButton() {
        do {
            let presentationSheet = try cancelUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
}

// MARK: - Private
extension ControlBarInteractor {
    private func updateSheetStore(presentationSheet: PresentationSheet) {
        sheetStore.overwriteSheet(presentationSheet)
        
        if presentationSheet.hasSelectedCells() {
            sheetStore.setDisplayMarkerControlBar(true)
        } else {
            sheetStore.setDisplayMarkerControlBar(false)
        }
    }
}
