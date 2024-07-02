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
    
    init(
        isDisplayMarkerControlBar: Bool = false,
        isDisplayAddSubMarkerAlert: Bool = false
    ) {
        self.sheet = ConvertManager.getImmutableSheet(GameSetter.shared.getSheet())
        self.isDisplayMarkerControlBar = isDisplayMarkerControlBar
        self.isDisplayAddSubMarkerAlert = isDisplayAddSubMarkerAlert
    }
    
    func getCellSize(_ screenWidth: CGFloat) -> (width: CGFloat, height: CGFloat) {
        let colCount = CGFloat(sheet.colNames.count)
        let tempWidth = (screenWidth - 10*(colCount+1)) / (colCount+2)
        
        let cellWidth = tempWidth < 40 ? tempWidth : 40
        
        return (tempWidth, cellWidth)
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
}
