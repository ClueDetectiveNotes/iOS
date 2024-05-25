//
//  MarkerControlBarInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct MarkerControlBarInteractor {
    private var sheetStore: SheetStore
    private let chooseMainMarkerUseCase: ChooseMainMarkerUseCase
    private let chooseSubMarkerUseCase: ChooseSubMarkerUseCase
    private let cancelClickedCellUseCase: CancelClickedCellUseCase
    
    init(
        sheetStore: SheetStore,
        chooseMainMarkerUseCase: ChooseMainMarkerUseCase = ChooseMainMarkerUseCase(),
        chooseSubMarkerUseCase: ChooseSubMarkerUseCase = ChooseSubMarkerUseCase(),
        cancelClickedCellUseCase: CancelClickedCellUseCase = CancelClickedCellUseCase()
    ) {
        self.sheetStore = sheetStore
        self.chooseMainMarkerUseCase = chooseMainMarkerUseCase
        self.chooseSubMarkerUseCase = chooseSubMarkerUseCase
        self.cancelClickedCellUseCase = cancelClickedCellUseCase
    }
    
    func chooseMainMarker(_ marker: MainMarker) {
        let presentationSheet = chooseMainMarkerUseCase.execute(marker)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func chooseSubMarker(_ marker: SubMarker) {
        let presentationSheet = chooseSubMarkerUseCase.execute(marker)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func clickCancelButton() {
        let presentationSheet = cancelClickedCellUseCase.execute()
        
        updateSheetStore(presentationSheet: presentationSheet)
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
