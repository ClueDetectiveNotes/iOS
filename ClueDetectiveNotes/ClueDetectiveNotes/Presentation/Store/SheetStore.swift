//
//  SheetStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/9/24.
//

import Foundation

final class SheetStore: ObservableObject {
    @Published private(set) var sheet: PresentationSheet
    @Published private(set) var isShowingMarkerControlBar: Bool
    @Published var isShowingAddSubMarkerAlert: Bool
    @Published var isVisibleScreen: Bool
    @Published var isShowingCheckMarkerAlert: Bool
    @Published var isHiddenAnswer: Bool
    @Published var isHiddenLockImage: Bool
    
    init(
        isShowingMarkerControlBar: Bool = false,
        isShowingAddSubMarkerAlert: Bool = false,
        isVisibleScreen: Bool = true,
        isShowingCheckMarkerAlert: Bool = false,
        isHiddenAnswer: Bool = false,
        isHiddenLockImage: Bool = false
    ) {
        self.sheet = ConvertManager.getImmutableSheet(GameSetter.shared.getSheet())
        self.isShowingMarkerControlBar = isShowingMarkerControlBar
        self.isShowingAddSubMarkerAlert = isShowingAddSubMarkerAlert
        self.isVisibleScreen = isVisibleScreen
        self.isShowingCheckMarkerAlert = isShowingCheckMarkerAlert
        self.isHiddenAnswer = isHiddenAnswer
        self.isHiddenLockImage = isHiddenLockImage
    }
    
    func overwriteSheet(_ newSheet: PresentationSheet) {
        sheet = newSheet
    }
    
    func setIsShowingMarkerControlBar(_ value: Bool) {
        isShowingMarkerControlBar = value
    }
    
    func setIsShowingAddSubMarkerAlert(_ value: Bool) {
        isShowingAddSubMarkerAlert = value
    }
    
    func setIsShowingCheckMarkerAlert(_ value: Bool) {
        isShowingCheckMarkerAlert = value
    }
    
    func toggleIsHiddenAnswer() {
        isHiddenAnswer.toggle()
    }
}
