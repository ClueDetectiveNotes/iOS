//
//  AddSubMarkerTypeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/25/24.
//

struct AddSubMarkerTypeUseCase {
    private var setting: Setting
    
    init(setting: Setting = GameSetter.shared.getSetting()) {
        self.setting = setting
    }
    
    func execute(_ marker: SubMarker) throws -> PresentationSetting {
        try setting.addSubMarkerType(marker)
        
        return createPresentationSetting()
    }
}

// MARK: - Private
extension AddSubMarkerTypeUseCase {
    private func createPresentationSetting() -> PresentationSetting {
        return PresentationSetting(
            players: setting.getPlayers(),
            edition: setting.getEdition(),
            subMarkerTypes: setting.getSubMarkerTypes(),
            publicCards: setting.getPublicCards()
        )
    }
}
