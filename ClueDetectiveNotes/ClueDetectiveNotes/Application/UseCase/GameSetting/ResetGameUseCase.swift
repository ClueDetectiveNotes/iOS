//
//  ResetGameUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/31/24.
//

import Foundation

struct ResetGameUseCase {
    func execute() throws -> PresentationGameSetting {
        GameSetter.shared.resetGame()
        
        return createPresentationGameSetting()
    }
}

// MARK: - Private
extension ResetGameUseCase {
    private func createPresentationGameSetting() -> PresentationGameSetting {
        return ConvertManager.getImmutableGameSetting()
    }
}
