//
//  InitMyCardsUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/3/24.
//

struct InitMyCardsUseCase {
    func execute() throws -> PresentationGameSetting {
        let game = GameSetter.shared.getGame() // 이때 처음 game이 만들어져야함
        
        guard let user = game.getUser() else {
            throw GameError.notFoundUser
        }
        
        if user.cards.isEmpty {
            for _ in 0..<game.getMyCardsCount() {
                user.takeCard(Card(rawName: "", name: "", type: .none))
            }
        }
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension InitMyCardsUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting(
            selectedPublicCards: GameSetter.shared.getGame().getPublicOne().cards,
            selectedMyCards: GameSetter.shared.getGame().getUser()?.cards ?? []
        )
    }
}
