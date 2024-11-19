//
//  RemoveSubMarkerTypeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/18/24.
//

import Foundation

struct RemoveSubMarkerTypeUseCase {
    private var subMarkerTypes: SubMarkerTypes
    
    init(subMarkerTypes: SubMarkerTypes = SubMarkerTypes.shared) {
        self.subMarkerTypes = subMarkerTypes
    }
    
    func execute(indexSet: IndexSet) throws -> [SubMarkerType] {
        try subMarkerTypes.removeSubMarkerType(indexSet)
        
        return createPresentationSubMarkerTypes()
    }
}

// MARK: - Private
extension RemoveSubMarkerTypeUseCase {
    private func createPresentationSubMarkerTypes() -> [SubMarkerType] {
        return ConvertManager.getImmutableSubMarkerTypes()
    }
}
