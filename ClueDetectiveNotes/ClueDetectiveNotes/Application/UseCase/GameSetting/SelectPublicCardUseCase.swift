//
//  SelectPublicCardUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/2/24.
//

struct SelectPublicCardUseCase {
    func execute(selectedCard: Card) throws -> PresentationGameSetting {
        let game = GameSetter.shared.getGame()
        let publicCardsCount = GameSetter.shared.getPublicCardsCount()
        
        let publicOne = game.getPublicOne()
        var tempCards = publicOne.cards.filter { $0.type != .none }
        
        if tempCards.contains(selectedCard) {
            if let index = tempCards.firstIndex(of: selectedCard) {
                tempCards.remove(at: index)
                game.getUnknownOne().takeCard(selectedCard)
            }
        } else {
            if tempCards.count < publicCardsCount {
                tempCards.append(selectedCard)
            }
        }
        
        let n = publicCardsCount - tempCards.count
        
        if n > 0 {
            for _ in 0..<n {
                tempCards.append(Card(rawName: "", name: "", type: .none))
            }
        }
        
        publicOne.setCards(tempCards)
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension SelectPublicCardUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting(
            selectedPublicCards: GameSetter.shared.getGame().getPublicOne().cards,
            selectedMyCards: GameSetter.shared.getGame().getUser()?.cards ?? []
        )
    }
}
