//
//  SelectMyCardUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/2/24.
//

struct SelectMyCardUseCase {
    func execute(selectedCard: Card) throws -> PresentationGameSetting {
        let game = GameSetter.shared.getGame()
        let myCardsCount = GameSetter.shared.getMyCardsCount()
        
        guard let user = game.getUser() else {
            throw GameError.notFoundUser
        }
        
        var tempCards = user.cards.filter { $0.type != .none }
        
        if tempCards.contains(selectedCard) {
            if let index = tempCards.firstIndex(of: selectedCard) {
                tempCards.remove(at: index)
                game.getUnknownOne().takeCard(selectedCard)
            }
        } else {
            if tempCards.count < myCardsCount {
                tempCards.append(selectedCard)
            }
        }
        
        let n = myCardsCount - tempCards.count
        
        if n > 0 {
            for _ in 0..<n {
                tempCards.append(Card(rawName: "", name: "", type: .none))
            }
        }
        
        user.setCards(tempCards)
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension SelectMyCardUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting(
            selectedPublicCards: GameSetter.shared.getGame().getPublicOne().cards,
            selectedMyCards: GameSetter.shared.getGame().getUser()?.cards ?? []
        )
    }
}
