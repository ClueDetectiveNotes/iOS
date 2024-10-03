//
//  MarkerControlBarInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct MarkerControlBarInteractor {
    private var sheetStore: SheetStore
    private var controlBarStore: ControlBarStore
    private let chooseMainMarkerUseCase: AnyUseCase<MainMarker>
    private let chooseSubMarkerUseCase: AnyUseCase<SubMarker>
    private let cancelClickedCellUseCase: AnyUseCase<Int>
    private let addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase
    
    init(
        sheetStore: SheetStore,
        controlBarStore: ControlBarStore,
        chooseMainMarkerUseCase: AnyUseCase<MainMarker> = AnyUseCase(SnapshotDecorator(ChooseMainMarkerUseCase())),
        chooseSubMarkerUseCase: AnyUseCase<SubMarker> = AnyUseCase(SnapshotDecorator(ChooseSubMarkerUseCase())),
        cancelClickedCellUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(CancelClickedCellUseCase())),
        addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase = AddSubMarkerTypeUseCase()
    ) {
        self.sheetStore = sheetStore
        self.controlBarStore = controlBarStore
        self.chooseMainMarkerUseCase = chooseMainMarkerUseCase
        self.chooseSubMarkerUseCase = chooseSubMarkerUseCase
        self.cancelClickedCellUseCase = cancelClickedCellUseCase
        self.addSubMarkerTypeUseCase = addSubMarkerTypeUseCase
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
    
    func clickCloseButton() {
        do {
            let presentationSheet = try cancelClickedCellUseCase.execute()
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    func clickPlusButton() {
        sheetStore.setDisplayAddSubMarkerAlert(true)
    }
    
    func addSubMarker(_ marker: SubMarker) {
        do {
            let presentationControlBar = try addSubMarkerTypeUseCase.execute(marker)
            
            updateControlBarStore(presentationControlBar: presentationControlBar)
        } catch {
            
        }
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
    
    private func updateControlBarStore(presentationControlBar: PresentationControlBar) {
        controlBarStore.overwriteControlBar(presentationControlBar)
    }
}
