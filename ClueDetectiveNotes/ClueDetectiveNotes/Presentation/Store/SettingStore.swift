//
//  SettingStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

import Foundation

final class SettingStore: ObservableObject {
    @Published private(set) var setting: PresentationSetting

    init() {
        self.setting = ConvertManager.getImmutableSetting(GameSetter.shared.getSetting())
    }
    
    func overwriteSetting(_ newSetting: PresentationSetting) {
        setting = newSetting
    }
}
