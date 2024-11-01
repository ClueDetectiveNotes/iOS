//
//  GameSettingStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

import Foundation

final class GameSettingStore: ObservableObject {
    @Published var gameSetting: PresentationGameSetting
    
    @Published private(set) var isDisabledMinusButton: Bool
    @Published private(set) var isDisabledPlusButton: Bool
    
    @Published private(set) var isDisablePlayerSettingNextButton: Bool
    @Published private(set) var isDisablePlayerDetailSettingNextButton: Bool
    
    @Published private(set) var isDisablePublicCardsSettingNextButton: Bool
    @Published private(set) var isDisableMyCardsSettingNextButton: Bool
    
    init(
        gameSetting: PresentationGameSetting = ConvertManager.getImmutableGameSetting(),
        isDisabledMinusButton: Bool = true,
        isDisabledPlusButton: Bool = false,
        isDisablePlayerSettingNextButton: Bool = true,
        isDisablePlayerDetailSettingNextButton: Bool = true,
        isDisablePublicCardsSettingNextButton: Bool = true,
        isDisableMyCardsSettingNextButton: Bool = true
    ) {
        self.gameSetting = gameSetting
        self.isDisabledMinusButton = isDisabledMinusButton
        self.isDisabledPlusButton = isDisabledPlusButton
        self.isDisablePlayerSettingNextButton = isDisablePlayerSettingNextButton
        self.isDisablePlayerDetailSettingNextButton = isDisablePlayerDetailSettingNextButton
        self.isDisablePublicCardsSettingNextButton = isDisablePublicCardsSettingNextButton
        self.isDisableMyCardsSettingNextButton = isDisableMyCardsSettingNextButton
    }
    
    func overwriteGameSetting(_ newGameSetting: PresentationGameSetting) {
        gameSetting = newGameSetting
    }
    
    func setIsDisabledMinusButton(_ value: Bool) {
        isDisabledMinusButton = value
    }
    
    func setIsDisabledPlusButton(_ value: Bool) {
        isDisabledPlusButton = value
    }
    
    func setIsDisablePlayerSettingNextButton(_ value: Bool) {
        isDisablePlayerSettingNextButton = value
    }
    
    func setIsDisablePlayerDetailSettingNextButton(_ value: Bool) {
        isDisablePlayerDetailSettingNextButton = value
    }
    
    func setIsDisablePublicCardsSettingNextButton(_ value: Bool) {
        isDisablePublicCardsSettingNextButton = value
    }
    
    func setIsDisableMyCardsSettingNextButton(_ value: Bool) {
        isDisableMyCardsSettingNextButton = value
    }
}
