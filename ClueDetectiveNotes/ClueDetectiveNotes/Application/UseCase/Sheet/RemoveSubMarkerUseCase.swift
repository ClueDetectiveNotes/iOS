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

struct RemoveMarkerUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ marker: any Markable) throws -> PresentationSheet {
        if let cell = sheet.getSelectedCells().first {
            if let _ = marker as? MainMarker {
                cell.removeMainMarker()
            } else if let marker = marker as? SubMarker {
                cell.removeSubMarker(marker)
            }
        }
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension RemoveMarkerUseCase {
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
