//
//  CardHolders.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/17/24.
//

final class CardHolders {
    private var players: [Player]
    private var answer: CardHolder
    private var publicOne: CardHolder
    private var unknownOne: CardHolder
    
    init(
        players: [Player]
    ) {
        self.players = players
        self.answer = CardHolder(name: "정답")
        self.publicOne = CardHolder(name: "공용")
        self.unknownOne = CardHolder(name: "미확인")
    }
    
    func getPlayers() -> [Player] {
        return players
    }
    
    func getUser() -> Player? {
        return players.first(where: { $0 is User })
    }
    
    func getAnswer() -> CardHolder {
        return answer
    }
    
    func getPublicOne() -> CardHolder {
        return publicOne
    }
    
    func getUnknownOne() -> CardHolder {
        return unknownOne
    }
    
    func setAnswer(_ answer: CardHolder) {
        self.answer = answer
    }
    
    func setPublicOne(_ publicOne: CardHolder) {
        self.publicOne = publicOne
    }
    
    func setUnknownOne(_ unknownOne: CardHolder) {
        self.unknownOne = unknownOne
    }
}
