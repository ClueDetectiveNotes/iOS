//
//  ReorderSubMarkerTypesUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/18/24.
//

import Foundation

struct ReorderSubMarkerTypesUseCase {
    private var subMarkerTypes: SubMarkerTypes
    
    init(subMarkerTypes: SubMarkerTypes = SubMarkerTypes.shared) {
        self.subMarkerTypes = subMarkerTypes
    }
    
    func execute(source: IndexSet, destination: Int) -> [SubMarkerType] {
        subMarkerTypes.reorderSubMarkerTypes(source: source, destination: destination)
        
        return createPresentationSubMarkerTypes()
    }
}

// MARK: - Private
extension ReorderSubMarkerTypesUseCase {
    private func createPresentationSubMarkerTypes() -> [SubMarkerType] {
        return ConvertManager.getImmutableSubMarkerTypes()
    }
}
