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
    @Published var autoAnswerMode: Bool
    @Published var subMarkerTypes: [SubMarkerType]
    @Published var privacyScreenOpacity: Double
    
    @Published var isShowingAddSubMarkerAlert: Bool
    @Published var isShowingDeleteSubMarkerAlert: Bool
    @Published var isShowingInitSubMarkerAlert: Bool
    
    init(
        language: Language = .korean,
        screenMode: ScreenMode = .system,
        autoAnswerMode: Bool = false,
        subMarkerTypes: [SubMarkerType] = ConvertManager.getImmutableSubMarkerTypes(),
        privacyScreenOpacity: Double = 0.98,
        isShowingAddSubMarkerAlert: Bool = false,
        isShowingDeleteSubMarkerAlert: Bool = false,
        isShowingInitSubMarkerAlert: Bool = false
    ) {
        
        self.language = language
        self.screenMode = screenMode
        self.autoAnswerMode = autoAnswerMode
        self.subMarkerTypes = subMarkerTypes
        self.privacyScreenOpacity = privacyScreenOpacity
        self.isShowingAddSubMarkerAlert = isShowingAddSubMarkerAlert
        self.isShowingDeleteSubMarkerAlert = isShowingDeleteSubMarkerAlert
        self.isShowingInitSubMarkerAlert = isShowingInitSubMarkerAlert
    }
    
    func setLanguage(_ language: Language) {
        self.language = language
    }
    
    func setScreenMode(_ screenMode: ScreenMode) {
        self.screenMode = screenMode
    }
    
    func setAutoAnswerMode(_ autoAnswerMode: Bool) {
        self.autoAnswerMode = autoAnswerMode
    }
    
    func setPrivacyScreenOpacity(_ privacyScreenOpacity: Double) {
        self.privacyScreenOpacity = privacyScreenOpacity
    }
    
    func setIsShowingAddSubMarkerAlert(_ value: Bool) {
        isShowingAddSubMarkerAlert = value
    }
    
    func setIsShowingDeleteSubMarkerAlert(_ value: Bool) {
        isShowingDeleteSubMarkerAlert = value
    }
    
    func setIsShowingInitSubMarkerAlert(_ value: Bool) {
        isShowingInitSubMarkerAlert = value
    }
    
    func overwriteSubMarkerTypes(_ newSubMarkerTypes: [SubMarkerType]) {
        subMarkerTypes = newSubMarkerTypes
    }
}
