//
//  GameSetter.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

final class GameSetter {
    static let shared = GameSetter()
    
    private var edition: Edition = .classic
    private var players: [Player] = []
    private var game: Game?
    
    private init() { }
    
    func getEdition() -> Edition {
        return edition
    }
    
    func getPlayers() -> [Player] {
        if players.isEmpty {
            players.append(Other(name: ""))
            players.append(Other(name: ""))
            players.append(Other(name: ""))
        }
        
        return players
    }
    
    func getUser() -> Player? {
        for player in players {
            if player is User {
                return player
            }
        }
        return nil
    }
    
    func getPublicCardsCount() -> Int {
        let cardsCount = edition.deck.allCardsCount()
        let playerCount = players.count
        
        return (cardsCount - 3) % playerCount
    }
    
    func getMyCardsCount() -> Int {
        let cardsCount = edition.deck.allCardsCount()
        let playerCount = players.count
        
        return (cardsCount - 3) / playerCount
    }
    
    // players가 설정되기 전에 game이 생성되지 않도록 막는 것도 필요해보인다.
    func getGame() -> Game {
        if let game {
            return game
        } else {
            let newGame = Game(
                deck: edition.deck,
                players: players
            )
            self.game = newGame
            return newGame
        }
    }
    
    func getSheet() -> Sheet {
        let game = getGame()
        
        return game.getSheet()
    }
    
    func setPlayers(_ players: [Player]) {
        self.players = players
    }
    
    func destroyGame() {
        game = nil
        
        if !players.isEmpty {
            for player in players {
                player.removeAllCard()
            }
        }
    }
}
