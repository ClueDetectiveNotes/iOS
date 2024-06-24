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
    private let createPlayersUseCase: CreatePlayersUseCase
    
    init(
        settingStore: SettingStore,
        addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase = AddSubMarkerTypeUseCase(),
        createPlayersUseCase: CreatePlayersUseCase = CreatePlayersUseCase()
    ) {
        self.settingStore = settingStore
        self.addSubMarkerTypeUseCase = addSubMarkerTypeUseCase
        self.createPlayersUseCase = createPlayersUseCase
    }
    
    func addSubMarker(_ marker: SubMarker) {
        do {
            let presentationSetting = try addSubMarkerTypeUseCase.execute(marker)
            updateSettingStore(presentationSetting: presentationSetting)
        } catch {
            os_log("%{public}@", type: .default, error.localizedDescription)
        }
    }
    
    func clickMinusButton() {
        let minPlayerCount = GameSetter.shared.getSetting().getMinPlayerCount()
        
        if settingStore.count > minPlayerCount {
            decrementCount()
            removeLastPlayerName()
        }
        
        if settingStore.count == minPlayerCount {
            settingStore.setIsDisabledMinusButton(true)
        } else {
            settingStore.setIsDisabledMinusButton(false)
            settingStore.setIsDisabledPlusButton(false)
        }
    }
    
    func clickPlusButton() {
        let maxPlayerCount = GameSetter.shared.getSetting().getMaxPlayerCount()
        
        if settingStore.count <  maxPlayerCount {
            incrementCount()
            appendPlayerName("")
        }
        
        if settingStore.count == maxPlayerCount {
            settingStore.setIsDisabledPlusButton(true)
        } else {
            settingStore.setIsDisabledMinusButton(false)
            settingStore.setIsDisabledPlusButton(false)
        }
    }
    
    func clickPlayerSettingNextButton() {
        if isValidPlayerNames() {
            let trimmingNames = trimmingPlayerNames()
            settingStore.overwritePlayerNames(trimmingNames)
        }
    }
    
    func selectPlayer(_ playerName: String) {
        settingStore.setSelectedPlayer(playerName)
    }
    
    func clickPlayerDetailSettingNextButton() {
        do {
            let playerNames = settingStore.playerNames
            let userName = settingStore.selectedPlayer
            
            let presentationSetting = try createPlayersUseCase.execute(playerNames, userName)
            
            updateSettingStore(presentationSetting: presentationSetting)
        } catch {
            
        }
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
    
    func isSelectedPlayer(_ playerName: String) -> Bool {
        return settingStore.selectedPlayer == playerName
    }
    
    func isEmptySelectedPlayer() -> Bool {
        return settingStore.selectedPlayer.isEmpty
    }
}

// MARK: - Private
extension SettingInteractor {
    private func updateSettingStore(presentationSetting: PresentationSetting) {
        settingStore.overwriteSetting(presentationSetting)
    }
    
    private func incrementCount() {
        settingStore.count += 1
    }
    
    private func decrementCount() {
        settingStore.count -= 1
    }
    
    private func appendPlayerName(_ name: String) {
        settingStore.playerNames.append(name)
    }
    
    private func removeLastPlayerName() {
        settingStore.playerNames.removeLast()
    }
    
    private func trimmingPlayerNames() -> [String] {
        return settingStore.playerNames.map {
            $0.trimmingCharacters(in: .whitespaces)
        }
    }
    
    private func isEmptyStrings(_ strings: [String]) -> Bool {
        for string in strings {
            if string.isEmpty {
                return true
            }
        }
        return false
    }
}
