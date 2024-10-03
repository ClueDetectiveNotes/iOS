//
//  InitGameUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/3/24.
//

import Foundation

struct InitGameUseCase {
    func execute() throws -> PresentationGameSetting {
        GameSetter.shared.destroyGame()
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension InitGameUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
