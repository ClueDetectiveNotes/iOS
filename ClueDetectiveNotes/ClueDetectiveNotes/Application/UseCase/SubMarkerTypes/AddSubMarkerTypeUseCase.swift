//
//  AddSubMarkerTypeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct AddSubMarkerTypeUseCase {
    private var subMarkerTypes: SubMarkerTypes
    
    init(subMarkerTypes: SubMarkerTypes = SubMarkerTypes.shared) {
        self.subMarkerTypes = subMarkerTypes
    }
    
    func execute(_ markerType: String) throws -> [SubMarkerType] {
        try subMarkerTypes.addSubMarkerType(markerType)
        
        print(subMarkerTypes.getSubMarkerTypes())
        return createPresentationSubMarkerTypes()
    }
}

// MARK: - Private
extension AddSubMarkerTypeUseCase {
    private func createPresentationSubMarkerTypes() -> [SubMarkerType] {
        return ConvertManager.getImmutableSubMarkerTypes()
    }
}
