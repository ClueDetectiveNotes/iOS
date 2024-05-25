//
//  SettingUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SettingUseCase {
    private var setting: Setting = GameSetter.shared.getSetting()
    
    func addSubMarker(_ marker: SubMarker) throws -> PresentationSetting {
        try setting.addSubMarkerType(marker)
        
        return createPresentationSetting()
    }
}

// MARK: - Private
extension SettingUseCase {
    private func createPresentationSetting() -> PresentationSetting {
        return PresentationSetting(
            players: setting.getPlayers(),
            edition: setting.getEdition(),
            subMarkerTypes: setting.getSubMarkerTypes()
        )
    }
}
