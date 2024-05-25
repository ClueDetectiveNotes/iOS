//
//  SettingInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

import OSLog

struct SettingInteractor {
    private var settingStore: SettingStore
    private let addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase
    
    init(
        settingStore: SettingStore,
        addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase = AddSubMarkerTypeUseCase()
    ) {
        self.settingStore = settingStore
        self.addSubMarkerTypeUseCase = addSubMarkerTypeUseCase
    }
    
    func addSubMarker(_ marker: SubMarker) {
        do {
            let presentationSetting = try addSubMarkerTypeUseCase.execute(marker)
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
