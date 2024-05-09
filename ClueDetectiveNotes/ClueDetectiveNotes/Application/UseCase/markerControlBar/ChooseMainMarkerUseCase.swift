//
//  ChooseMainMarkerUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/8/24.
//

struct ChooseMainMarkerUseCase {
    private var marker: MainMarker
    
    init(marker: MainMarker) {
        self.marker = marker
    }
    
    func execute() throws {
        let sheet = GameSetter.shared.getSheetInstance()
        
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.isEveryCellMarkedWithMainMarker(),
               sheet.isSameMainMarkerInEveryCell(marker) {
                sheet.getSelectedCells().forEach { cell in
                    cell.removeMainMarker()
                }
            } else {
                sheet.getSelectedCells().forEach { cell in
                    cell.setMainMarker(marker)
                }
            }
        case false:
            guard let cell = sheet.getSelectedCells().first else { return }
            
            if cell.equalsMainMarker(marker) {
                cell.removeMainMarker()
            } else {
                cell.setMainMarker(marker)
            }
        }
    }
}
