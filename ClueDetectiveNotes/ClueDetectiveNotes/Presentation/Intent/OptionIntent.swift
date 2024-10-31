//
//  OptionIntent.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/30/24.
//

import SwiftUI

struct OptionIntent {
    private var optionStore: OptionStore
    
    @AppStorage("language") private var language: Language = .korean
    @AppStorage("screenMode") private var screenMode: ScreenMode = .system
    @AppStorage("autoAnswerMode") private var autoAnswerMode: AutoAnswerMode = .off
    
    init(
        optionStore: OptionStore
    ) {
        self.optionStore = optionStore
    }
    
    // AppStorage에서 load
    func loadOption() {
        optionStore.setLanguage(language)
        optionStore.setScreenMode(screenMode)
        optionStore.setAutoAnswerMode(autoAnswerMode)
    }
    
    // AppStorage에 save
    func saveOption() {
        language = optionStore.language
        screenMode = optionStore.screenMode
        autoAnswerMode = optionStore.autoAnswerMode
    }
}
