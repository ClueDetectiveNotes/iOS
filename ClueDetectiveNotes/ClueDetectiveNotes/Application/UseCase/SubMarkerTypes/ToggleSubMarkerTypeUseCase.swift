//
//  ToggleSubMarkerTypeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/18/24.
//

struct ToggleSubMarkerTypeUseCase {
    private var subMarkerTypes: SubMarkerTypes
    
    init(subMarkerTypes: SubMarkerTypes = SubMarkerTypes.shared) {
        self.subMarkerTypes = subMarkerTypes
    }
    
    func execute(_ subMarkerType: SubMarkerType) throws -> [SubMarkerType] {
        try subMarkerTypes.toggleSubMarkerType(subMarkerType)
        
        return createPresentationSubMarkerTypes()
    }
}

// MARK: - Private
extension ToggleSubMarkerTypeUseCase {
    private func createPresentationSubMarkerTypes() -> [SubMarkerType] {
        return ConvertManager.getImmutableSubMarkerTypes()
    }
}
