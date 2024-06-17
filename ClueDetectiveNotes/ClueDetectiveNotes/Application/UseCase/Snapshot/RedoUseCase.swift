//
//  RedoUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

struct RedoUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ param: Int) throws -> PresentationSheet {
        let snapshot = try SnapshotManager.shared.popOffRedoSnapshot()
        
        try applyToSheet(snapshot)
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension RedoUseCase {
    private func applyToSheet(_ snapshot: Snapshot) throws {
        // sheet 상태 초기화
        sheet.resetSelectedState()
        
        // sheet set
        let mode = snapshot.getMode()
        
        switch mode {
        case .single:
            sheet.switchMode(.single)
            
            let selectedCellIds = snapshot.getSelectedCellIds()
            for selectedCellId in selectedCellIds {
                let cell = try sheet.findCell(id: selectedCellId)
                _ = try sheet.selectCell(cell)
            }
        case .multi:
            sheet.switchMode(.multi)
            
            let selectedCellIds = snapshot.getSelectedCellIds()
            for selectedCellId in selectedCellIds {
                let cell = try sheet.findCell(id: selectedCellId)
                _ = try sheet.multiSelectCell(cell)
            }
        case .preInference:
            sheet.switchMode(.preInference)
            
            let selectedRowNames = snapshot.getSelectedRowNames()
            for selectedRowName in selectedRowNames {
                _ = sheet.selectRowName(selectedRowName.value)
            }
            
            if let selectedColName = snapshot.getSelectedColName() {
                _ = sheet.selectColumnName(selectedColName)
            }
        case .inference:
            sheet.switchMode(.inference)
            
            let selectedRowNames = snapshot.getSelectedRowNames()
            for selectedRowName in selectedRowNames {
                _ = sheet.selectRowName(selectedRowName.value)
            }
            
            if let selectedColName = snapshot.getSelectedColName() {
                _ = sheet.selectColumnName(selectedColName)
            }
            
            try sheet.switchModeInInferenceMode()
        }

        // cells 초기화
        sheet.getCells().forEach { cell in
            cell.removeMainMarker()
            cell.removeSubMarkers()
        }
        
        // cells set
        try snapshot.getMainMarkerMarkedCells().forEach { mainMarkerMarkedCell in
            let cell = try sheet.findCell(id: mainMarkerMarkedCell.id)
            let mainMarker = mainMarkerMarkedCell.mainMarker
            cell.setMainMarker(mainMarker)
        }
        
        try snapshot.getSubMarkerMarkedCells().forEach { subMarkerMarkedCell in
            let cell = try sheet.findCell(id: subMarkerMarkedCell.id)
            let subMarkers = subMarkerMarkedCell.subMarkers
            cell.setSubMarkers(subMarkers)
        }
    }
    
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
