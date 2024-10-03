//
//  InitPublicCardsUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/2/24.
//

struct InitPublicCardsUseCase {
    func execute() throws -> PresentationGameSetting {
        let game = GameSetter.shared.getGame() // 이때 처음 game이 만들어져야함
        let publicOne = game.getPublicOne()
        
        if publicOne.cards.isEmpty {
            for _ in 0..<game.getPublicCardsCount() {
                publicOne.takeCard(Card(rawName: "", name: "", type: .none))
            }
        }
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension InitPublicCardsUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting(
            selectedPublicCards: GameSetter.shared.getGame().getPublicOne().cards,
            selectedMyCards: GameSetter.shared.getGame().getUser()?.cards ?? []
        )
    }
}
