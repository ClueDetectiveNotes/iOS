//
//  SettingStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

import Foundation

final class SettingStore: ObservableObject {
    @Published private(set) var setting: PresentationSetting
    @Published private(set) var isDisabledMinusButton: Bool
    @Published private(set) var isDisabledPlusButton: Bool
    @Published private(set) var isDisplayChosenCardsView: Bool = false
    @Published private(set) var isDisplayChooseCardView: Bool = false
    
    
    @Published var playerCount: Int
    @Published var playerNames: [String]
    @Published var selectedPlayer: String
    @Published var selectedPublicCards: [ClueCard]
    
    init(
        isDisabledMinusButton: Bool = true,
        isDisabledPlusButton: Bool = false
    ) {
        self.setting = ConvertManager.getImmutableSetting(GameSetter.shared.getSetting())
        self.playerCount = GameSetter.shared.getSetting().getMinPlayerCount()
        self.playerNames = Array(repeating: "", count: GameSetter.shared.getSetting().getMinPlayerCount())
        
        self.isDisabledMinusButton = isDisabledMinusButton
        self.isDisabledPlusButton = isDisabledPlusButton
        
        self.selectedPlayer = ""
        self.selectedPublicCards = []
    }
    
    func overwriteSetting(_ newSetting: PresentationSetting) {
        setting = newSetting
    }
    
    func overwritePlayerNames(_ newNames: [String]) {
        playerNames = newNames
    }
    
    func setIsDisabledMinusButton(_ value: Bool) {
        isDisabledMinusButton = value
    }
    
    func setIsDisabledPlusButton(_ value: Bool) {
        isDisabledPlusButton = value
    }
    
    func setSelectedPlayer(_ playerName: String) {
        selectedPlayer = playerName
    }
    
    func overwriteSelectedPublicCards(_ cards: [ClueCard]) {
        selectedPublicCards = cards
    }
}
