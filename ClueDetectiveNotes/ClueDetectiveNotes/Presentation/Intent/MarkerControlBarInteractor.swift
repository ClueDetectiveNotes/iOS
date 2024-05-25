//
//  MarkerControlBarInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct MarkerControlBarInteractor {
    private var sheetStore: SheetStore
    private let markerControlBarUseCase: MarkerControlBarUseCase
    
    init(
        sheetStore: SheetStore,
        markerControlBarUseCase: MarkerControlBarUseCase = MarkerControlBarUseCase()
    ) {
        self.sheetStore = sheetStore
        self.markerControlBarUseCase =  markerControlBarUseCase
    }
    
    func chooseMainMarker(_ marker: MainMarker) {
        let presentationSheet = markerControlBarUseCase.chooseMainMarker(marker)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func chooseSubMarker(_ marker: SubMarker) {
        let presentationSheet = markerControlBarUseCase.chooseSubMarker(marker)
        
        updateSheetStore(presentationSheet: presentationSheet)
    }
    
    func clickCancelButton() {
        let presentationSheet = markerControlBarUseCase.clickCancelButton()
        
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
