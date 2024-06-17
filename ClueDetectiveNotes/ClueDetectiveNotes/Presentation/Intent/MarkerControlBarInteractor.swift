//
//  MarkerControlBarInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct MarkerControlBarInteractor {
    private var sheetStore: SheetStore
    private let chooseMainMarkerUseCase: AnyUseCase<MainMarker>
    private let chooseSubMarkerUseCase: AnyUseCase<SubMarker>
    private let cancelClickedCellUseCase: AnyUseCase<Int>
    
    init(
        sheetStore: SheetStore,
        chooseMainMarkerUseCase: AnyUseCase<MainMarker> = AnyUseCase(SnapshotDecorator(ChooseMainMarkerUseCase())),
        chooseSubMarkerUseCase: AnyUseCase<SubMarker> = AnyUseCase(SnapshotDecorator(ChooseSubMarkerUseCase())),
        cancelClickedCellUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(CancelClickedCellUseCase()))
    ) {
        self.sheetStore = sheetStore
        self.chooseMainMarkerUseCase = chooseMainMarkerUseCase
        self.chooseSubMarkerUseCase = chooseSubMarkerUseCase
        self.cancelClickedCellUseCase = cancelClickedCellUseCase
    }
    
    func chooseMainMarker(_ marker: MainMarker) {
        do {
            let presentationSheet = try chooseMainMarkerUseCase.execute(marker)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func chooseSubMarker(_ marker: SubMarker) {
        do {
            let presentationSheet = try chooseSubMarkerUseCase.execute(marker)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickCancelButton() {
        do {
            let presentationSheet = try cancelClickedCellUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickPlusButton() {
        sheetStore.setDisplayAddSubMarkerAlert(true)
    }
}

// MARK: - Private
extension MarkerControlBarInteractor {
    private func updateSheetStore(presentationSheet: PresentationSheet) {
        sheetStore.overwriteSheet(presentationSheet)
        
        if presentationSheet.hasSelectedCells() {
            sheetStore.setDisplayMarkerControlBar(true)
        } else {
            sheetStore.setDisplayMarkerControlBar(false)
        }
    }
}
