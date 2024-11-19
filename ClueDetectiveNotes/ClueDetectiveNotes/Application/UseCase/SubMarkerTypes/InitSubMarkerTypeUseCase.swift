//
//  InitSubMarkerTypeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/19/24.
//

struct InitSubMarkerTypeUseCase {
    private var subMarkerTypes: SubMarkerTypes
    
    init(subMarkerTypes: SubMarkerTypes = SubMarkerTypes.shared) {
        self.subMarkerTypes = subMarkerTypes
    }
    
    func execute() -> [SubMarkerType] {
        subMarkerTypes.initSubMarkerType()
        
        return createPresentationSubMarkerTypes()
    }
}

// MARK: - Private
extension InitSubMarkerTypeUseCase {
    private func createPresentationSubMarkerTypes() -> [SubMarkerType] {
        return ConvertManager.getImmutableSubMarkerTypes()
    }
}
