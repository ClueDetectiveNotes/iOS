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
    
    init(
        isDisplayMarkerControlBar: Bool = false
    ) {
        self.sheet = GameSetter.shared.getPresentationSheet()
        self.isDisplayMarkerControlBar = isDisplayMarkerControlBar
    }
    
    func overwriteSheet(_ newSheet: PresentationSheet) {
        sheet = newSheet
    }
    
    func setDisplayMarkerControlBar(_ value: Bool) {
        isDisplayMarkerControlBar = value
    }
}
