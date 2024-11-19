//
//  ControlBarStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/17/24.
//

import Foundation

final class ControlBarStore: ObservableObject {
    @Published var showOptionView: Bool
    @Published var showToHomeAlert: Bool
    @Published var showRestartGameAlert: Bool
    @Published var wantsToGoHome: Bool
    @Published var wantsToRestartGame: Bool
    
    init(
        showOptionView: Bool = false,
        showToHomeAlert: Bool = false,
        showRestartGameAlert: Bool = false,
        wantsToGoHome: Bool = false,
        wantsToRestartGame: Bool = false
    ) {
        self.showOptionView = showOptionView
        self.showToHomeAlert = showToHomeAlert
        self.showRestartGameAlert = showRestartGameAlert
        self.wantsToGoHome = wantsToGoHome
        self.wantsToRestartGame = wantsToRestartGame
    }
    
    func setShowOptionView(_ value: Bool) {
        showOptionView = value
    }
    
    func setShowToHomeAlert(_ value: Bool) {
        showToHomeAlert = value
    }
    
    func setShowGameAgainAlert(_ value: Bool) {
        showRestartGameAlert = value
    }
    
    func setWantsToGoHome(_ value: Bool) {
        wantsToGoHome = value
    }
    
    func setWantsToRestartGame(_ value: Bool) {
        wantsToRestartGame = value
    }
}
