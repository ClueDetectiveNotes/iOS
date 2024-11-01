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
        
        let tempIndex = players.firstIndex(where: { $0.name == trimmingName})
        
        guard tempIndex == nil
                || (tempIndex != nil && tempIndex == index) else {
            throw SettingError.alreadyExistsPlayer
        }
        
        if tempIndex == nil {
            players[index].name = trimmingName
            GameSetter.shared.setPlayers(players)
        }
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension SetPlayerNameUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
