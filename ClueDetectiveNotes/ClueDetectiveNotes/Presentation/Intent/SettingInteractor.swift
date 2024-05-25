//
//  SettingInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SettingInteractor {
    private var settingStore: SettingStore
    private let settingUseCase: SettingUseCase
    
    init(
        settingStore: SettingStore,
        settingUseCase: SettingUseCase = SettingUseCase()
    ) {
        self.settingStore = settingStore
        self.settingUseCase = settingUseCase
    }
    
    func addSubMarker(_ marker: SubMarker) {
        let presentationSetting = settingUseCase.addSubMarker(marker)
        
        updateSettingStore(presentationSetting: presentationSetting)
    }
    
    private func updateSettingStore(presentationSetting: PresentationSetting) {
        settingStore.overwriteSetting(presentationSetting)
    }
}
