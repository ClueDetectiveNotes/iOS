//
//  Game.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/17/24.
//

final class Game {
    private var deck: Deck
    private var cardHolders: CardHolders
    private var sheet: Sheet?
    
    init(
        deck: Deck,
        players: [Player]
    ) {
        self.deck = deck
        self.cardHolders = CardHolders(players: players)
        
        let initUnknownOne = CardHolder(
            name: "미확인",
            cards: deck.allCards()
        )
        
        cardHolders.setUnknownOne(initUnknownOne)
    }
    
    func getCards() -> [Card] {
        return deck.allCards()
    }
    
    func getPublicCardsCount() -> Int {
        let cardsCount = deck.allCardsCount()
        let playerCount = cardHolders.getPlayers().count
        
        return (cardsCount - 3) % playerCount
    }
    
    func getMyCardsCount() -> Int {
        let cardsCount = deck.allCardsCount()
        let playerCount = cardHolders.getPlayers().count
        
        return (cardsCount - 3) / playerCount
    }
    
    func getPlayers() -> [Player] {
        return cardHolders.getPlayers()
    }
    
    func getUser() -> Player? {
        return cardHolders.getUser()
    }
    
    func getPublicOne() -> CardHolder {
        return cardHolders.getPublicOne()
    }
    
    func getUnknownOne() -> CardHolder {
        return cardHolders.getUnknownOne()
    }
    
    func getSheet() -> Sheet {
        if let sheet {
            return sheet
        } else {
            let newSheet = Sheet(
                cardHolders: cardHolders,
                cards: deck
            )
            self.sheet = newSheet
            return newSheet
        }
    }
}
