//
//  SheetStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/9/24.
//

import Foundation

final class SheetStore: ObservableObject {
    @Published var sheet: PresentationSheet
    @Published var isDisplayMarkerControlBar: Bool
    
    init(
        isDisplayMarkerControlBar: Bool = false
    ) {
        self.sheet = GameSetter.shared.getPresentationSheet()
        self.isDisplayMarkerControlBar = isDisplayMarkerControlBar
    }
}
