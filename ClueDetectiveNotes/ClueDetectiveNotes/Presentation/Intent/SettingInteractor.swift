//
//  SettingInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

import OSLog

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
        do {
            let presentationSetting = try settingUseCase.addSubMarker(marker)
            updateSettingStore(presentationSetting: presentationSetting)
        } catch {
            os_log("%{public}@", type: .default, error.localizedDescription)
        }
    }
}

// MARK: - Private
extension SettingInteractor {
    private func updateSettingStore(presentationSetting: PresentationSetting) {
        settingStore.overwriteSetting(presentationSetting)
    }
}
