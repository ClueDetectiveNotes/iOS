//
//  SheetStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/9/24.
//

import Foundation

final class SheetStore: ObservableObject {
    @Published private(set) var sheet: PresentationSheet
    @Published private(set) var isDisplayMarkerControlBar: Bool
    @Published var isDisplayAddSubMarkerAlert: Bool
    @Published var isVisibleScreen: Bool
    @Published var isDisplayCheckMarkerAlert: Bool
    @Published var isHiddenAnswer: Bool
    
    init(
        isDisplayMarkerControlBar: Bool = false,
        isDisplayAddSubMarkerAlert: Bool = false,
        isVisibleScreen: Bool = true,
        isDisplayCheckMarkerAlert: Bool = false,
        isHiddenAnswer: Bool = false
    ) {
        self.sheet = ConvertManager.getImmutableSheet(GameSetter.shared.getSheet())
        self.isDisplayMarkerControlBar = isDisplayMarkerControlBar
        self.isDisplayAddSubMarkerAlert = isDisplayAddSubMarkerAlert
        self.isVisibleScreen = isVisibleScreen
        self.isDisplayCheckMarkerAlert = isDisplayCheckMarkerAlert
        self.isHiddenAnswer = isHiddenAnswer
    }
    
    func overwriteSheet(_ newSheet: PresentationSheet) {
        sheet = newSheet
    }
    
    func setDisplayMarkerControlBar(_ value: Bool) {
        isDisplayMarkerControlBar = value
    }
    
    func setDisplayAddSubMarkerAlert(_ value: Bool) {
        isDisplayAddSubMarkerAlert = value
    }
    
    func setDisplayCheckMarkerAlert(_ value: Bool) {
        isDisplayCheckMarkerAlert = value
    }
    
    func toggleIsHiddenAnswer() {
        isHiddenAnswer.toggle()
    }
}
