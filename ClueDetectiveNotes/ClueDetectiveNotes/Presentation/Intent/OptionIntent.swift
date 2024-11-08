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
//    @AppStorage("autoAnswerMode") private var autoAnswerMode: AutoAnswerMode = .off
    @AppStorage("autoAnswerMode") private var autoAnswerMode: Bool = false
    
    init(
        optionStore: OptionStore
    ) {
        self.optionStore = optionStore
    }
    
    func clickLanguage(_ language: Language) {
        optionStore.setLanguage(language)
        self.language = optionStore.language
    }
    
    func clickScreenMode(_ screenMode: ScreenMode) {
        optionStore.setScreenMode(screenMode)
        self.screenMode = optionStore.screenMode
    }
    
    func clickAutoAnswerMode(_ autoAnswerMode: Bool) {
        optionStore.setAutoAnswerMode(autoAnswerMode)
        self.autoAnswerMode = optionStore.autoAnswerMode
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
