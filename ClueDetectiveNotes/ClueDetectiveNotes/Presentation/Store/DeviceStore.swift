//
//  DeviceStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/5/24.
//

import Foundation

final class DeviceStore: ObservableObject {
    @Published private(set) var screenSize: CGSize
    private(set) var originSize: CGSize
    
    init(
        screenSize: CGSize = .init(width: 200, height: 200),
        originSize: CGSize = .zero
    ) {
        self.screenSize = screenSize
        self.originSize = originSize
    }
    
    func getCellSize(_ colOfCount: Int) -> (width: CGFloat, height: CGFloat) {
        let screenWidth = screenSize.width
        
        let colCount = CGFloat(colOfCount)
        let tempWidth = (screenWidth - 5*(colCount+1)) / (colCount+2)
        
        let cellHeight = tempWidth < 40 ? tempWidth : 40
        
        return (tempWidth, cellHeight)
    }
    
    func setScreenSize(_ value: CGSize) {
        screenSize = value
    }
    
    func setOriginSize(_ value: CGSize) {
        originSize = value
    }
}
