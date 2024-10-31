//
//  OptionStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/30/24.
//

import Foundation

final class OptionStore: ObservableObject {
    @Published var language: Language
    @Published var screenMode: ScreenMode
    @Published var autoAnswerMode: AutoAnswerMode
    
    init(
        language: Language = .korean,
        screenMode: ScreenMode = .system,
        autoAnswerMode: AutoAnswerMode = .off
    ) {
        self.language = language
        self.screenMode = screenMode
        self.autoAnswerMode = autoAnswerMode
    }
    
    func setLanguage(_ language: Language) {
        self.language = language
    }
    
    func setScreenMode(_ screenMode: ScreenMode) {
        self.screenMode = screenMode
    }
    
    func setAutoAnswerMode(_ autoAnswerMode: AutoAnswerMode) {
        self.autoAnswerMode = autoAnswerMode
    }
}
