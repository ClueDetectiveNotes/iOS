//
//  SheetStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/9/24.
//

import Foundation

final class SheetStore: ObservableObject {
    @Published var sheet: Sheet
    @Published var isDisplayMarkerControlBar: Bool
    
    init(
        sheet: Sheet = GameSetter.shared.getSheetInstance(),
        isDisplayMarkerControlBar: Bool = false
    ) {
        self.sheet = sheet
        self.isDisplayMarkerControlBar = isDisplayMarkerControlBar
    }
}
