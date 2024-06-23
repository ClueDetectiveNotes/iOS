//
//  SettingStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

import Foundation

final class SettingStore: ObservableObject {
    @Published private(set) var setting: PresentationSetting
    @Published private(set) var count: Int
    @Published var playerNames: [String]
    
    @Published private(set) var isDisabledMinusButton: Bool
    @Published private(set) var isDisabledPlusButton: Bool
    
    @Published private(set) var selectedPlayer: String
    
    
    init(
        isDisabledMinusButton: Bool = true,
        isDisabledPlusButton: Bool = false
    ) {
        self.setting = ConvertManager.getImmutableSetting(GameSetter.shared.getSetting())
        self.count = GameSetter.shared.getSetting().getMinPlayerCount()
        self.playerNames = Array(repeating: "", count: GameSetter.shared.getSetting().getMinPlayerCount())
        
        self.isDisabledMinusButton = isDisabledMinusButton
        self.isDisabledPlusButton = isDisabledPlusButton
        
        self.selectedPlayer = ""
    }
    
    func overwriteSetting(_ newSetting: PresentationSetting) {
        setting = newSetting
    }
    
    func incrementCount() {
        count += 1
    }
    
    func decrementCount() {
        count -= 1
    }
    
    func appendPlayerName(_ name: String) {
        playerNames.append(name)
    }
    
    func removeLastPlayerName() {
        playerNames.removeLast()
    }
    
    func isValidPlayerNames() -> Bool {
        let trimmingNames = trimmingPlayerNames()
        
        guard !isEmptyStrings(trimmingNames) else {
            return false
        }
        
        guard Set(trimmingNames).count == trimmingNames.count else {
            return false
        }
        
        return true
    }
    
    func trimmingPlayerNames() -> [String] {
        return playerNames.map {
            $0.trimmingCharacters(in: .whitespaces)
        }
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
    
    func isSelectedPlayer(_ playerName: String) -> Bool {
        return selectedPlayer == playerName
    }
    
    func isEmptySelectedPlayer() -> Bool {
        return selectedPlayer.isEmpty
    }
    
    func setSelectedPlayer(_ playerName: String) {
        selectedPlayer = playerName
    }
}

extension SettingStore {
    private func isEmptyStrings(_ strings: [String]) -> Bool {
        for string in strings {
            if string.isEmpty {
                return true
            }
        }
        return false
    }
}
