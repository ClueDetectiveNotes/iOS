//
//  ControlBarStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/17/24.
//

import Foundation

final class ControlBarStore: ObservableObject {
    @Published var isShowingOptionView: Bool
    @Published var isShowingToHomeAlert: Bool
    @Published var isShowingRestartGameAlert: Bool
    @Published var wantsToGoHome: Bool
    @Published var wantsToRestartGame: Bool
    
    init(
        isShowingOptionView: Bool = false,
        isShowingToHomeAlert: Bool = false,
        isShowingRestartGameAlert: Bool = false,
        wantsToGoHome: Bool = false,
        wantsToRestartGame: Bool = false
    ) {
        self.isShowingOptionView = isShowingOptionView
        self.isShowingToHomeAlert = isShowingToHomeAlert
        self.isShowingRestartGameAlert = isShowingRestartGameAlert
        self.wantsToGoHome = wantsToGoHome
        self.wantsToRestartGame = wantsToRestartGame
    }
    
    func setIsShowingOptionView(_ value: Bool) {
        isShowingOptionView = value
    }
    
    func setIsShowingToHomeAlert(_ value: Bool) {
        isShowingToHomeAlert = value
    }
    
    func setIsShowingGameAgainAlert(_ value: Bool) {
        isShowingRestartGameAlert = value
    }
    
    func setWantsToGoHome(_ value: Bool) {
        wantsToGoHome = value
    }
    
    func setWantsToRestartGame(_ value: Bool) {
        wantsToRestartGame = value
    }
}
