//
//  OptionIntent.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/30/24.
//

import SwiftUI

struct OptionIntent {
    //private var sheetStore: SheetStore
    private var optionStore: OptionStore
    //private var controlBarStore: ControlBarStore
    //private let addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase
    
    @AppStorage("language") private var language: Language = .korean
    @AppStorage("screenMode") private var screenMode: ScreenMode = .system
    @AppStorage("autoAnswerMode") private var autoAnswerMode: AutoAnswerMode = .off
    
    init(
        //sheetStore: SheetStore,
        optionStore: OptionStore
        //controlBarStore: ControlBarStore,
        //addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase = AddSubMarkerTypeUseCase()
    ) {
        //self.sheetStore = sheetStore
        self.optionStore = optionStore
        //self.controlBarStore = controlBarStore
        //self.addSubMarkerTypeUseCase = addSubMarkerTypeUseCase
    }
    
    func loadOption() {
        optionStore.setLanguage(language)
        optionStore.setScreenMode(screenMode)
        optionStore.setAutoAnswerMode(autoAnswerMode)
    }
    
    func saveOption() {
        language = optionStore.language
        screenMode = optionStore.screenMode
        autoAnswerMode = optionStore.autoAnswerMode
    }
    
    func setLanguage(_ language: Language) {
        self.language = language
        saveOption()
    }
    
    func setScreenMode(_ screenMode: ScreenMode) {
        self.screenMode = screenMode
        saveOption()
    }
    
    func setAutoAnswerMode(_ autoAnswerMode: AutoAnswerMode) {
        self.autoAnswerMode = autoAnswerMode
        saveOption()
    }
    
}
