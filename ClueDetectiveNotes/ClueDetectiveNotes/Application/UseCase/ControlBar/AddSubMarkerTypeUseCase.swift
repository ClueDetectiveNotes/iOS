//
//  AddSubMarkerTypeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct AddSubMarkerTypeUseCase {
    private var subMarkerType: SubMarkerType
    
    init(subMarkerType: SubMarkerType = SubMarkerType.shared) {
        self.subMarkerType = subMarkerType
    }
    
    func execute(_ marker: SubMarker) throws -> PresentationControlBar {
        try subMarkerType.addSubMarkerType(marker.notation)
        
        return createPresentationControlBar()
    }
}

// MARK: - Private
extension AddSubMarkerTypeUseCase {
    private func createPresentationControlBar() -> PresentationControlBar {
        return PresentationControlBar(subMarkerTypes: subMarkerType.getSubMarkerTypes())
    }
}
