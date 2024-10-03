//
//  SetPlayerNameUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

import Foundation

struct SetPlayerNameUseCase {
    func execute(index: Int, name: String) throws -> PresentationGameSetting {
        let players = GameSetter.shared.getPlayers()
        let trimmingName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmingName.isEmpty else {
            throw SettingError.nameIsEmpty
        }
        
        guard !players.contains(where: { $0.name == trimmingName }) else {
            throw SettingError.alreadyExistsPlayer
        }
        
        players[index].name = trimmingName
        GameSetter.shared.setPlayers(players)
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension SetPlayerNameUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
