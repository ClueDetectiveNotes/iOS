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
    private let createPublicCardsUseCase : CreatePublicCardsUseCase
    
    init(
        settingStore: SettingStore,
        addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase = AddSubMarkerTypeUseCase(),
        createPlayersUseCase: CreatePlayersUseCase = CreatePlayersUseCase(),
        createPublicCardsUseCase : CreatePublicCardsUseCase = CreatePublicCardsUseCase()
    ) {
        self.settingStore = settingStore
        self.addSubMarkerTypeUseCase = addSubMarkerTypeUseCase
        self.createPlayersUseCase = createPlayersUseCase
        self.createPublicCardsUseCase = createPublicCardsUseCase
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
        
        if settingStore.playerCount > minPlayerCount {
            decrementPlayerCount()
            removeLastPlayerName()
        }
        
        if settingStore.playerCount == minPlayerCount {
            settingStore.setIsDisabledMinusButton(true)
        } else {
            settingStore.setIsDisabledMinusButton(false)
            settingStore.setIsDisabledPlusButton(false)
        }
    }
    
    func clickPlusButton() {
        let maxPlayerCount = GameSetter.shared.getSetting().getMaxPlayerCount()
        
        if settingStore.playerCount <  maxPlayerCount {
            incrementPlayerCount()
            appendPlayerName("")
        }
        
        if settingStore.playerCount == maxPlayerCount {
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
    
    func clickPublicCardsSettingNextButton() {
        do {
            let publicCards = settingStore.selectedPublicCards.filter { $0.type != .none }
            
            let presentationSetting = try createPublicCardsUseCase.execute(publicCards)
            
            updateSettingStore(presentationSetting: presentationSetting)
        } catch {
            print(error)
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
    
    //
    
    func initSelectedPublicCards() {
        // 기존 갯수와 같다면 초기화 하지 않아도 돼 이거 구현하기
        let emptyCard = ClueCard(rawName: "", name: "", type: .none)
        let cards: [ClueCard] = Array(repeating: emptyCard, count: settingStore.setting.getPublicCardsCount())
        
        settingStore.overwriteSelectedPublicCards(cards)
    }
    
    func isExistPublicCard() -> Bool {
        return settingStore.setting.getPublicCardsCount() > 0
    }
    
    func isCardSelectionComplete() -> Bool {
        let count = settingStore.selectedPublicCards.filter { $0.type != .none }.count
        return count == settingStore.setting.getPublicCardsCount()
    }
    
    func clickCard(card: ClueCard) {
        var tempCards = settingStore.selectedPublicCards.filter { $0.type != .none }
        
        // 이미 있는 카드면 삭제
        if tempCards.contains(card) {
            if let index = tempCards.firstIndex(of: card) {
                tempCards.remove(at: index)
            }
        } else { // 없는 카드면 추가
            if tempCards.count < settingStore.setting.getPublicCardsCount() {
                tempCards.append(card)
            }
        }
        
        let n = settingStore.setting.getPublicCardsCount() - tempCards.count
        
        // tempCards가 아직 모자라면 남은 배열은 nil로 채워줌
        if n > 0 {
            for _ in 0..<n {
                tempCards.append(ClueCard(rawName: "", name: "", type: .none))
            }
        }
        
        // 덮어 씌우기
        settingStore.overwriteSelectedPublicCards(tempCards)
    }
    
    func clickCard2(card: ClueCard?) {
        guard let card else { return }
        
        var tempCards = settingStore.selectedPublicCards.filter { $0.type != .none }
        
        // 이미 있는 카드면 삭제
        if tempCards.contains(card) {
            if let index = tempCards.firstIndex(of: card) {
                tempCards.remove(at: index)
            }
        }
        
        let n = settingStore.setting.getPublicCardsCount() - tempCards.count
        
        // tempCards가 아직 모자라면 남은 배열은 nil로 채워줌
        if n > 0 {
            for _ in 0..<n {
                tempCards.append(ClueCard(rawName: "", name: "", type: .none))
            }
        }
        
        // 덮어 씌우기
        settingStore.overwriteSelectedPublicCards(tempCards)
    }
}

// MARK: - Private
extension SettingInteractor {
    private func updateSettingStore(presentationSetting: PresentationSetting) {
        settingStore.overwriteSetting(presentationSetting)
    }
    
    private func incrementPlayerCount() {
        settingStore.playerCount += 1
    }
    
    private func decrementPlayerCount() {
        settingStore.playerCount -= 1
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
