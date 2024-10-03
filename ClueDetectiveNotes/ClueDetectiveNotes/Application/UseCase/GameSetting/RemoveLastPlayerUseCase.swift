//
//  RemoveLastPlayerUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 9/18/24.
//

struct RemoveLastPlayerUseCase {
    func execute() throws -> PresentationGameSetting {
        var players = GameSetter.shared.getPlayers()
        
        if players.count > 3 {
            players.removeLast()
            GameSetter.shared.setPlayers(players)
        }
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension RemoveLastPlayerUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
