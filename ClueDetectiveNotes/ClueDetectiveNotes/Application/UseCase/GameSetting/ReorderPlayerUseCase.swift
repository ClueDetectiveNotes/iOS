//
//  ReorderPlayerUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/2/24.
//

import Foundation

struct ReorderPlayerUseCase {
    func execute(source: IndexSet, destination: Int) throws -> PresentationGameSetting {
        var players = GameSetter.shared.getPlayers()
        
        players.move(fromOffsets: source, toOffset: destination)
        
        GameSetter.shared.setPlayers(players)
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension ReorderPlayerUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
