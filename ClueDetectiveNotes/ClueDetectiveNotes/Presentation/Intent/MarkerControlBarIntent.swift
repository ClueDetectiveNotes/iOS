//
//  MarkerControlBarIntent.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct MarkerControlBarIntent {
    private var optionStore: OptionStore
    private var sheetStore: SheetStore
    private var controlBarStore: ControlBarStore
    private let chooseMainMarkerUseCase: AnyUseCase<MainMarker>
    private let chooseSubMarkerUseCase: AnyUseCase<SubMarker>
    private let cancelClickedCellUseCase: AnyUseCase<Int>
    private let addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase
    private let chooseMainMarkerInAutoAnswerModeUseCase: AnyUseCase<MainMarker>
    
    init(
        optionStore: OptionStore,
        sheetStore: SheetStore,
        controlBarStore: ControlBarStore,
        chooseMainMarkerUseCase: AnyUseCase<MainMarker> = AnyUseCase(SnapshotDecorator(ChooseMainMarkerUseCase())),
        chooseSubMarkerUseCase: AnyUseCase<SubMarker> = AnyUseCase(SnapshotDecorator(ChooseSubMarkerUseCase())),
        cancelClickedCellUseCase: AnyUseCase<Int> = AnyUseCase(SnapshotDecorator(CancelClickedCellUseCase())),
        addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase = AddSubMarkerTypeUseCase(),
        chooseMainMarkerInAutoAnswerModeUseCase: AnyUseCase<MainMarker> = AnyUseCase(SnapshotDecorator(ChooseMainMarkerInAutoAnswerModeUseCase()))
    ) {
        self.optionStore = optionStore
        self.sheetStore = sheetStore
        self.controlBarStore = controlBarStore
        self.chooseMainMarkerUseCase = chooseMainMarkerUseCase
        self.chooseSubMarkerUseCase = chooseSubMarkerUseCase
        self.cancelClickedCellUseCase = cancelClickedCellUseCase
        self.addSubMarkerTypeUseCase = addSubMarkerTypeUseCase
        self.chooseMainMarkerInAutoAnswerModeUseCase = chooseMainMarkerInAutoAnswerModeUseCase
    }
    
    func chooseMainMarker(_ marker: MainMarker, autoAnswerMode: Bool) {
        switch autoAnswerMode {
        case true:
            checkAlertDisplayInAuto(marker)
        case false:
            chooseMainMarkerInNotAuto(marker)
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
        sheetStore.setIsShowingAddSubMarkerAlert(true)
        //optionStore.setIsShowingAddSubMarkerAlert(true)
    }
    
    func addSubMarkerType(_ markerType: String) {
        do {
            let presentationSubMarkerTypes = try addSubMarkerTypeUseCase.execute(markerType)
            
            updateSubMarkerTypes(presentationSubMarkerTypes: presentationSubMarkerTypes)
        } catch {
            
        }
    }
    
    func clickYesButtonInCheckMarkerAlert() {
        chooseMainMarkerInAuto(MainMarker(notation: .check))
    }
}

// MARK: - Private
extension MarkerControlBarIntent {
    // TODO: - 오토모드인지 아닌지 가드문으로 확인하기
    private func checkAlertDisplayInAuto(_ marker: MainMarker) {
        // Check 마커가 선택되었을 때
        if marker.notation == .check {
            let selectedCells = sheetStore.sheet.selectedCells
            var isDisplay = false
            
            // 1개라도 cell의 lock이 false이고, 정답이 아닌 경우 얼럿 띄우기
            for selectedCell in selectedCells {
                if !selectedCell.isLock
                    && selectedCell.colName.cardHolder is Player {
                    isDisplay = true
                }
            }
            
            if isDisplay {
                sheetStore.setIsShowingCheckMarkerAlert(isDisplay)
            } else {
                chooseMainMarkerInAuto(marker)
            }
        } else {
            chooseMainMarkerInAuto(marker)
        }
    }
    
    private func chooseMainMarkerInAuto(_ marker: MainMarker) {
        do {
            let presentationSheet = try chooseMainMarkerInAutoAnswerModeUseCase.execute(marker)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    private func chooseMainMarkerInNotAuto(_ marker: MainMarker) {
        do {
            let presentationSheet = try chooseMainMarkerUseCase.execute(marker)
            
            updateSheetStore(presentationSheet: presentationSheet)
        } catch {
            
        }
    }
    
    private func updateSheetStore(presentationSheet: PresentationSheet) {
        sheetStore.overwriteSheet(presentationSheet)
        
        if presentationSheet.hasSelectedCells() {
            sheetStore.setIsShowingMarkerControlBar(true)
        } else {
            sheetStore.setIsShowingMarkerControlBar(false)
        }
    }
    
    private func updateSubMarkerTypes(presentationSubMarkerTypes: [SubMarkerType]) {
        optionStore.overwriteSubMarkerTypes(presentationSubMarkerTypes)
    }
}
