//
//  ControlBarInterator.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

struct ControlBarInterator {
    private var sheetStore: SheetStore
    private let undoUseCase: UndoUseCase
    private let redoUseCase: RedoUseCase
    //private let clearUseCase: ClearUseCase // 선택된 셀 마커 삭제
    //private let cancelUseCase: CancelUsecase // 선택된 셀이 있으면 다 언셀렉
    
    init(
        sheetStore: SheetStore,
        undoUseCase: UndoUseCase = UndoUseCase(),
        redoUseCase: RedoUseCase = RedoUseCase()
    ) {
        self.sheetStore = sheetStore
        self.undoUseCase = undoUseCase
        self.redoUseCase = redoUseCase
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
}

// MARK: - Private
extension ControlBarInterator {
    private func updateSheetStore(presentationSheet: PresentationSheet) {
        sheetStore.overwriteSheet(presentationSheet)
        
        if presentationSheet.hasSelectedCells() {
            sheetStore.setDisplayMarkerControlBar(true)
        } else {
            sheetStore.setDisplayMarkerControlBar(false)
        }
    }
}
