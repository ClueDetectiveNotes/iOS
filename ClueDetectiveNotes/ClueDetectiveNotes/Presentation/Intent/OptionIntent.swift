//
//  OptionIntent.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/30/24.
//

import SwiftUI

struct OptionIntent {
    private var optionStore: OptionStore
    private let addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase
    private let removeSubMarkerTypeUseCase : RemoveSubMarkerTypeUseCase
    private let reorderSubMarkerTypesUseCase : ReorderSubMarkerTypesUseCase
    private let toggleSubMarkerTypeUseCase: ToggleSubMarkerTypeUseCase
    private let initSubMarkerTypeUseCase: InitSubMarkerTypeUseCase
    
    @AppStorage("language") private var language: Language = .korean
    @AppStorage("screenMode") private var screenMode: ScreenMode = .system
    @AppStorage("autoAnswerMode") private var autoAnswerMode: Bool = false
    
    init(
        optionStore: OptionStore,
        addSubMarkerTypeUseCase: AddSubMarkerTypeUseCase = AddSubMarkerTypeUseCase(),
        removeSubMarkerTypeUseCase : RemoveSubMarkerTypeUseCase = RemoveSubMarkerTypeUseCase(),
        reorderSubMarkerTypesUseCase : ReorderSubMarkerTypesUseCase = ReorderSubMarkerTypesUseCase(),
        toggleSubMarkerTypeUseCase: ToggleSubMarkerTypeUseCase = ToggleSubMarkerTypeUseCase(),
        initSubMarkerTypeUseCase: InitSubMarkerTypeUseCase = InitSubMarkerTypeUseCase()
    ) {
        self.optionStore = optionStore
        self.addSubMarkerTypeUseCase = addSubMarkerTypeUseCase
        self.removeSubMarkerTypeUseCase = removeSubMarkerTypeUseCase
        self.reorderSubMarkerTypesUseCase = reorderSubMarkerTypesUseCase
        self.toggleSubMarkerTypeUseCase = toggleSubMarkerTypeUseCase
        self.initSubMarkerTypeUseCase = initSubMarkerTypeUseCase
    }
    
    func clickLanguage(_ language: Language) {
        optionStore.setLanguage(language)
        optionStore.setMultiLang(SQLiteHelper.shared.getMultiLang(language: language.code))
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
    
    func clickPlusButton() {
        //sheetStore.setIsShowingAddSubMarkerAlert(true)
        optionStore.setIsShowingAddSubMarkerAlert(true)
    }
    
    func clickSubMarkerInitButton() {
        optionStore.setIsShowingInitSubMarkerAlert(true)
    }
    
    func initSubMarkerType() {
        let presentationSubMarkerTypes = initSubMarkerTypeUseCase.execute()
        
        updateSubMarkerTypes(presentationSubMarkerTypes: presentationSubMarkerTypes)
    }
    
    func addSubMarkerType(_ markerType: String) {
        do {
            let presentationSubMarkerTypes = try addSubMarkerTypeUseCase.execute(markerType)
            
            updateSubMarkerTypes(presentationSubMarkerTypes: presentationSubMarkerTypes)
        } catch {
            print(error)
        }
    }
    
    func deleteSubMarkerType(indexSet: IndexSet) {
        do {
            let presentationSubMarkerTypes = try removeSubMarkerTypeUseCase.execute(indexSet: indexSet)
            
            updateSubMarkerTypes(presentationSubMarkerTypes: presentationSubMarkerTypes)
        } catch {
            optionStore.setIsShowingDeleteSubMarkerAlert(true)
            print(error)
        }
    }
    
    func reorderSubMarkerTypes(source: IndexSet, destination: Int) {
        let presentationSubMarkerTypes = reorderSubMarkerTypesUseCase.execute(source: source, destination: destination)
        
        updateSubMarkerTypes(presentationSubMarkerTypes: presentationSubMarkerTypes)
    }
    
    func toggleSubMarkerType(_ subMarkerType: SubMarkerType) {
        do {
            let presentationSubMarkerTypes = try toggleSubMarkerTypeUseCase.execute(subMarkerType)
            
            updateSubMarkerTypes(presentationSubMarkerTypes: presentationSubMarkerTypes)
        } catch {
            print(error)
        }
    }
    
    // AppStorage에서 load
    func loadOption() {
        optionStore.setLanguage(language)
        optionStore.setScreenMode(screenMode)
        optionStore.setAutoAnswerMode(autoAnswerMode)
        optionStore.setMultiLang(SQLiteHelper.shared.getMultiLang(language: language.code))
    }
    
    // AppStorage에 save
    func saveOption() {
        language = optionStore.language
        screenMode = optionStore.screenMode
        autoAnswerMode = optionStore.autoAnswerMode
    }
}

extension OptionIntent {
    private func updateSubMarkerTypes(presentationSubMarkerTypes: [SubMarkerType]) {
        optionStore.overwriteSubMarkerTypes(presentationSubMarkerTypes)
    }
}
