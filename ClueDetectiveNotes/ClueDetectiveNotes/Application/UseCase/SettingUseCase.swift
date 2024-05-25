//
//  SettingUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SettingUseCase {
    private var setting: Setting = GameSetter.shared.getSetting()
    
    func addSubMarker(_ marker: SubMarker) -> PresentationSetting {
        // 한 글자 판별, 빈 값 판별, 스페이스 하나 판별
        // 중복 판별
        setting.addSubMarkerType(marker)
        
        return createPresentationSetting()
    }
    
    private func createPresentationSetting() -> PresentationSetting {
        return PresentationSetting(
            players: setting.getPlayers(),
            edition: setting.getEdition(),
            subMarkerTypes: setting.getSubMarkerTypes()
        )
    }
}
