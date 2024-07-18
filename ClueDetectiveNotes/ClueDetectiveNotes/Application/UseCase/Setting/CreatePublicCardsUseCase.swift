//
//  CreatePublicCardsUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/15/24.
//

struct CreatePublicCardsUseCase {
    private var setting: Setting
    
    init(setting: Setting = GameSetter.shared.getSetting()) {
        self.setting = setting
    }
    
    func execute(_ publicCards: [ClueCard]) throws -> PresentationSetting {
        setting.removeAllPublicCards()
        
        for card in publicCards {
            try setting.addPublicCard(card)
        }

        print(setting.getPublicCards())
        return createPresentationSetting()
    }
}

// MARK: - Private
extension CreatePublicCardsUseCase {
    private func createPresentationSetting() -> PresentationSetting {
        return PresentationSetting(
            players: setting.getPlayers(),
            edition: setting.getEdition(),
            subMarkerTypes: setting.getSubMarkerTypes(),
            publicCards: setting.getPublicCards()
        )
    }
}
