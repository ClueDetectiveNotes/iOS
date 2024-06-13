//
//  ChooseSubMarkerUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct ChooseSubMarkerUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ marker: SubMarker) -> PresentationSheet {
        switch sheet.isMultiMode() {
        case true:
            if sheet.isEveryCellMarkedWithSameSubMarker(marker) {
                sheet.getSelectedCells().forEach { cell in
                    cell.removeSubMarker(marker)
                }
            } else {
                sheet.getSelectedCells().forEach { cell in
                    if !cell.containsSubMarker(marker) {
                        cell.setSubMarker(marker)
                    }
                }
            }
        case false:
            if let cell = sheet.getSelectedCells().first {
                if cell.containsSubMarker(marker) {
                    cell.removeSubMarker(marker)
                } else {
                    cell.setSubMarker(marker)
                }
            }
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ChooseSubMarkerUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
