//
//  RemoveSubMarkerUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 12/17/24.
//

import Foundation

struct RemoveSubMarkerUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ indexSet: IndexSet) throws -> PresentationSheet {
        if let cell = sheet.getSelectedCells().first {
            var subMarkers = cell.getSubMarkers()
            
            subMarkers.remove(atOffsets: indexSet)
            cell.setSubMarkers(subMarkers)
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension RemoveSubMarkerUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
