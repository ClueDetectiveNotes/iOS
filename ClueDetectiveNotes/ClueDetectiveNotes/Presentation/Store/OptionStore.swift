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
    //@Published var autoAnswerMode: AutoAnswerMode
    @Published var autoAnswerMode: Bool
    @Published var subMarkerTypes: [SubMarkerType]
    
    @Published var isShowingAddSubMarkerAlert: Bool
    @Published var isShowingDeleteSubMarkerAlert: Bool
    
    init(
        language: Language = .korean,
        screenMode: ScreenMode = .system,
        //autoAnswerMode: AutoAnswerMode = .off,
        autoAnswerMode: Bool = false,
        subMarkerTypes: [SubMarkerType] = ConvertManager.getImmutableSubMarkerTypes(),
        isShowingAddSubMarkerAlert: Bool = false,
        isShowingDeleteSubMarkerAlert: Bool = false
    ) {
        
        self.language = language
        self.screenMode = screenMode
        //self.autoAnswerMode = autoAnswerMode
        self.autoAnswerMode = autoAnswerMode
        self.subMarkerTypes = subMarkerTypes
        self.isShowingAddSubMarkerAlert = isShowingAddSubMarkerAlert
        self.isShowingDeleteSubMarkerAlert = isShowingDeleteSubMarkerAlert
    }
    
    func setLanguage(_ language: Language) {
        self.language = language
    }
    
    func setScreenMode(_ screenMode: ScreenMode) {
        self.screenMode = screenMode
    }
    
    //    func setAutoAnswerMode(_ autoAnswerMode: AutoAnswerMode) {
    //        self.autoAnswerMode = autoAnswerMode
    //    }
    
    func setAutoAnswerMode(_ autoAnswerMode: Bool) {
        self.autoAnswerMode = autoAnswerMode
    }
    
    func setIsShowingAddSubMarkerAlert(_ value: Bool) {
        isShowingAddSubMarkerAlert = value
    }
    
    func setIsShowingDeleteSubMarkerAlert(_ value: Bool) {
        isShowingDeleteSubMarkerAlert = value
    }
    
    func overwriteSubMarkerTypes(_ newSubMarkerTypes: [SubMarkerType]) {
        subMarkerTypes = newSubMarkerTypes
    }
}
