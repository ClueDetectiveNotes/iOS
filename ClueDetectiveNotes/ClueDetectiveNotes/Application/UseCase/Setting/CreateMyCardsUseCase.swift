//
//  CreateMyCardsUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/22/24.
//

struct CreateMyCardsUseCase {
    private var setting: Setting
    
    init(setting: Setting = GameSetter.shared.getSetting()) {
        self.setting = setting
    }
    
    func execute(_ myCards: [ClueCard]) throws -> PresentationSetting {
        setting.removeAllMyCards()
        
        for card in myCards {
            try setting.addMyCard(card)
        }
        
        return createPresentationSetting()
    }
}

// MARK: - Private
extension CreateMyCardsUseCase {
    private func createPresentationSetting() -> PresentationSetting {
        return PresentationSetting(
            players: setting.getPlayers(),
            edition: setting.getEdition(),
            subMarkerTypes: setting.getSubMarkerTypes(),
            publicCards: setting.getPublicCards(),
            myCards: setting.getMyCards()
        )
    }
}
