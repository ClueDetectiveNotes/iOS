//
//  AddPlayerUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

struct AddPlayerUseCase {
    func execute() throws -> PresentationGameSetting {
        var players = GameSetter.shared.getPlayers()
        
        if players.count < 6 {
            players.append(Other(name: ""))
            GameSetter.shared.setPlayers(players)
        }
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension AddPlayerUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
