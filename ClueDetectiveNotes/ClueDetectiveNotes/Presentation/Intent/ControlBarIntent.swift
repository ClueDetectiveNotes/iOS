//
//  ControlBarIntent.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

struct ControlBarIntent {
    private var sheetStore: SheetStore
    private var controlBarStore: ControlBarStore
    private let lockCellsUseCase: LockCellsUseCase
    private let unlockCellsUseCase: UnlockCellsUseCase
    private let undoUseCase: UndoUseCase
    private let redoUseCase: RedoUseCase
    private let skipNextUseCase: AnyUseCase<Int>
    private let skipPreviousUseCase: AnyUseCase<Int>
    private let clearUseCase: AnyUseCase<Int>
    private let cancelUseCase: AnyUseCase<Int>
    
    init(
        sheetStore: SheetStore,
        controlBarStore: ControlBarStore,
        lockCellsUseCase: LockCellsUseCase = LockCellsUseCase(),
        unlockCellsUseCase: UnlockCellsUseCase = UnlockCellsUseCase(),
        undoUseCase: UndoUseCase = UndoUseCase(),
        redoUseCase: RedoUseCase = RedoUseCase(),
        skipNextUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(SkipNextUseCase())),
        skipPreviousUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(SkipPreviousUseCase())),
        clearUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(ClearMarkerSelectedCellUseCase())),
        cancelUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(CancelClickedCellUseCase()))
    ) {
        self.sheetStore = sheetStore
        self.controlBarStore = controlBarStore
        self.lockCellsUseCase = lockCellsUseCase
        self.unlockCellsUseCase = unlockCellsUseCase
        self.undoUseCase = undoUseCase
        self.redoUseCase = redoUseCase
        self.skipNextUseCase = skipNextUseCase
        self.skipPreviousUseCase = skipPreviousUseCase
        self.clearUseCase = clearUseCase
        self.cancelUseCase = cancelUseCase
    }
    
    func tapLockButton() {
        do {
            let presentationSheet = try lockCellsUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func longPressLockButton() {
        do {
            let presentationSheet = try unlockCellsUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
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
    
    func clickSkipNext() {
        do {
            let presentationSheet = try skipNextUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickSkipPrevious() {
        do {
            let presentationSheet = try skipPreviousUseCase.execute()
            
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
    
    func clickOption() {
        controlBarStore.setShowOptionView(true)
    }
    
    func clickCancelButton() {
        do {
            let presentationSheet = try cancelUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickGoHomeInMoreMenu() {
        controlBarStore.setShowToHomeAlert(true)
    }
    
    func clickRestartGameInMoreMenu() {
        controlBarStore.setShowGameAgainAlert(true)
    }
    
    func goHome() {
        controlBarStore.setWantsToGoHome(true)
    }
    
    func restartGame() {
        controlBarStore.setWantsToRestartGame(true)
    }
    
    func clickHiddenAnswer() {
        sheetStore.toggleIsHiddenAnswer()
    }
}

// MARK: - Private
extension ControlBarIntent {
    private func updateSheetStore(presentationSheet: PresentationSheet) {
        sheetStore.overwriteSheet(presentationSheet)
        
        if presentationSheet.hasSelectedCells() {
            sheetStore.setDisplayMarkerControlBar(true)
        } else {
            sheetStore.setDisplayMarkerControlBar(false)
        }
    }
}
