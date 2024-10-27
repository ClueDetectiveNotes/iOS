//
//  GameSettingIntent.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

import Foundation

struct GameSettingIntent {
    private var gameSettingStore: GameSettingStore
    private let removeLastPlayerUseCase: RemoveLastPlayerUseCase
    private let addPlayerUseCase: AddPlayerUseCase
    private let setPlayerNameUseCase: SetPlayerNameUseCase
    private let reorderPlayerUseCase: ReorderPlayerUseCase
    private let selectUserUseCase: SelectUserUseCase
    private let selectPublicCardsUseCase: SelectPublicCardUseCase
    private let selectMyCardsUseCase: SelectMyCardUseCase
    private let initPublicCardsUseCase: InitPublicCardsUseCase
    private let initMyCardsUseCase : InitMyCardsUseCase
    private let initGameUseCase : InitGameUseCase
    
    init(
        gameSettingStore: GameSettingStore,
        removeLastPlayerUseCase: RemoveLastPlayerUseCase = RemoveLastPlayerUseCase(),
        addPlayerUseCase: AddPlayerUseCase = AddPlayerUseCase(),
        setPlayerNameUseCase: SetPlayerNameUseCase = SetPlayerNameUseCase(),
        reorderPlayerUseCase: ReorderPlayerUseCase = ReorderPlayerUseCase(),
        selectUserUseCase: SelectUserUseCase = SelectUserUseCase(),
        selectPublicCardsUseCase: SelectPublicCardUseCase = SelectPublicCardUseCase(),
        selectMyCardsUseCase: SelectMyCardUseCase = SelectMyCardUseCase(),
        initPublicCardsUseCase: InitPublicCardsUseCase = InitPublicCardsUseCase(),
        initMyCardsUseCase : InitMyCardsUseCase = InitMyCardsUseCase(),
        initGameUseCase : InitGameUseCase = InitGameUseCase()
    ) {
        self.gameSettingStore = gameSettingStore
        self.removeLastPlayerUseCase = removeLastPlayerUseCase
        self.addPlayerUseCase = addPlayerUseCase
        self.setPlayerNameUseCase = setPlayerNameUseCase
        self.reorderPlayerUseCase = reorderPlayerUseCase
        self.selectUserUseCase = selectUserUseCase
        self.selectPublicCardsUseCase = selectPublicCardsUseCase
        self.selectMyCardsUseCase = selectMyCardsUseCase
        self.initPublicCardsUseCase = initPublicCardsUseCase
        self.initMyCardsUseCase = initMyCardsUseCase
        self.initGameUseCase = initGameUseCase
    }
    
    func clickMinusButton() {
        let minPlayerCount = 3
        
        do {
            let presentationGameSetting = try removeLastPlayerUseCase.execute()
            
            if presentationGameSetting.playerCount == minPlayerCount {
                gameSettingStore.setIsDisabledMinusButton(true)
            } else {
                gameSettingStore.setIsDisabledMinusButton(false)
                gameSettingStore.setIsDisabledPlusButton(false)
            }
            
            setIsDisablePlayerSettingNextButton(playerNames: presentationGameSetting.playerNames)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
    
    func clickPlusButton() {
        let maxPlayerCount = 6
        
        do {
            let presentationGameSetting = try addPlayerUseCase.execute()
            
            if presentationGameSetting.playerCount == maxPlayerCount {
                gameSettingStore.setIsDisabledPlusButton(true)
            } else {
                gameSettingStore.setIsDisabledMinusButton(false)
                gameSettingStore.setIsDisabledPlusButton(false)
            }
            
            setIsDisablePlayerSettingNextButton(playerNames: presentationGameSetting.playerNames)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
    
    func setPlayerName(index: Int, name: String) {
        do {
            let presentationGameSetting = try setPlayerNameUseCase.execute(index: index, name: name)
            
            setIsDisablePlayerSettingNextButton(playerNames: presentationGameSetting.playerNames)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            gameSettingStore.setIsDisablePlayerSettingNextButton(true)
        }
    }

    func setIsDisablePlayerSettingNextButton(playerNames: [String]) {
        var disable: Bool = false
        
        for name in playerNames {
            if name.isEmpty { disable = true }
        }
        
        gameSettingStore.setIsDisablePlayerSettingNextButton(disable)
    }
    
    func reorderPlayer(source: IndexSet, destination: Int) {
        do {
            let presentationGameSetting = try reorderPlayerUseCase.execute(source: source, destination: destination)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
    
    func selectUser(name: String) {
        do {
            let presentationGameSetting = try selectUserUseCase.execute(name: name)
            
            
            gameSettingStore.setIsDisablePlayerDetailSettingNextButton(
                presentationGameSetting.selectedPlayer.isEmpty ? true : false
            )
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
    
    func initPublicCards() {
        do {
            let presentationGameSetting = try initPublicCardsUseCase.execute()
            
            setIsDisablePublicCardsSettingNextButton(presentationGameSetting.selectedPublicCards)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
    
    func initGame() {
        do {
            let presentationGameSetting = try initGameUseCase.execute()
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
            
        } catch {
            
        }
    }
    
    func setIsDisablePublicCardsSettingNextButton(_ cards: [Card]) {
        var disable: Bool = false
        
        for card in cards {
            if card.type == .none {
                disable = true
            }
        }
        
        gameSettingStore.setIsDisablePublicCardsSettingNextButton(disable)
    }
    
    
    
    func selectPublicCard(_ card: Card) {
        do {
            let presentationGameSetting = try selectPublicCardsUseCase.execute(selectedCard: card)
            
            setIsDisablePublicCardsSettingNextButton(presentationGameSetting.selectedPublicCards)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
    
    func setIsDisableMyCardsSettingNextButton(_ cards: [Card]) {
        var disable: Bool = false
        
        for card in cards {
            if card.type == .none {
                disable = true
            }
        }
        
        gameSettingStore.setIsDisableMyCardsSettingNextButton(disable)
    }
    
    func initMyCards() {
        do {
            let presentationGameSetting = try initMyCardsUseCase.execute()
            
            setIsDisableMyCardsSettingNextButton(presentationGameSetting.selectedMyCards)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
    
    func selectMyCard(_ card: Card) {
        do {
            let presentationGameSetting = try selectMyCardsUseCase.execute(selectedCard: card)

            setIsDisableMyCardsSettingNextButton(presentationGameSetting.selectedMyCards)
            
            updateGameSettingStore(presentationGameSetting: presentationGameSetting)
        } catch {
            
        }
    }
}

// MARK: - Private
extension GameSettingIntent {
    private func updateGameSettingStore(presentationGameSetting: PresentationGameSetting) {
        gameSettingStore.overwriteGameSetting(presentationGameSetting)
    }
}
