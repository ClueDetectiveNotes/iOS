//
//  ClearMarkerSelectedCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

struct ClearMarkerSelectedCellUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ param: Int) -> PresentationSheet {
        let cells = sheet.getSelectedCells()
        
        for cell in cells {
            cell.removeMainMarker()
            cell.removeSubMarkers()
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ClearMarkerSelectedCellUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
