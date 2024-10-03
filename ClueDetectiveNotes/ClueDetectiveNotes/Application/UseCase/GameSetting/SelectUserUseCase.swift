//
//  SelectUserUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/2/24.
//

import Foundation

// 나중에 id 기반으로 바꾸기 - hashable 필요
struct SelectUserUseCase {
    func execute(name: String) throws -> PresentationGameSetting {
        var players = GameSetter.shared.getPlayers()
        
        for (i, player) in players.enumerated() {
            if player.name == name {
                players[i] = User(name: player.name, cards: player.cards)
            } else {
                if player is User {
                    players[i] = Other(name: player.name, cards: player.cards)
                }
            }
        }
        
        GameSetter.shared.setPlayers(players)
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension SelectUserUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
