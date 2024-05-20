//
//  SettingInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SettingInteractor {
    private var settingStore: SettingStore
    private var setting: Setting = GameSetter.shared.getSetting()
    
    init(settingStore: SettingStore) {
        self.settingStore = settingStore
    }
    
    func execute(_ useCase: SettingUseCase) {
        switch useCase {
        case let .addSubMarker(marker):
            addSubMarker(marker)
        }
    }
}

extension SettingInteractor {
    private func addSubMarker(_ marker: SubMarker) {
        // 한 글자 판별, 빈 값 판별, 스페이스 하나 판별
        // 중복 판별
        setting.addSubMarkerType(marker)
        
        updatePresentationSetting()
    }
    
    private func updatePresentationSetting() {
        let presentationSetting = PresentationSetting(
            players: setting.getPlayers(),
            edition: setting.getEdition(),
            subMarkerTypes: setting.getSubMarkerTypes()
        )
        
        settingStore.overwriteSetting(presentationSetting)
    }
}
