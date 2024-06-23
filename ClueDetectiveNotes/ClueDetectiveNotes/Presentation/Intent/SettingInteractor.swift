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
            settingStore.decrementCount()
            //settingStore.removeLastPlayerName()
            var temp = settingStore.playerNames
            temp.removeLast()
            settingStore.playerNames = temp
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
            settingStore.incrementCount()
            settingStore.appendPlayerName("")
        }
        
        if settingStore.count == maxPlayerCount {
            settingStore.setIsDisabledPlusButton(true)
        } else {
            settingStore.setIsDisabledMinusButton(false)
            settingStore.setIsDisabledPlusButton(false)
        }
    }
    
    func clickPlayerSettingNextButton() {
        if settingStore.isValidPlayerNames() {
            let trimmingNames = settingStore.trimmingPlayerNames()
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
}

// MARK: - Private
extension SettingInteractor {
    private func updateSettingStore(presentationSetting: PresentationSetting) {
        settingStore.overwriteSetting(presentationSetting)
    }
}
