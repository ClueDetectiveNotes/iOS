//
//  GeometryStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/5/24.
//

import Foundation

final class GeometryStore: ObservableObject {
    @Published private(set) var screenSize: CGSize
    @Published private(set) var selectedRowName: RowName?
    
    private(set) var originSize: CGSize
    private(set) var originSizeWithoutSafeArea: CGSize = .zero
    private(set) var safeAreaHeight: (top: CGFloat, bottom: CGFloat) = (0, 0)
    private(set) var currentCoordinates: CGPoint?
    
    private(set) var cardNameWidth: CGFloat = 110
    private(set) var controlBarHeight: CGFloat = 40
    private(set) var markerControlBarHeight: CGFloat = 120
    private let cellMaxHeight: CGFloat = 40
    
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
        
        let tempWidth = ((screenWidth - cardNameWidth) / colCount) - 5
        
        let cellHeight = tempWidth < cellMaxHeight ? tempWidth : cellMaxHeight
        
        return (tempWidth, cellHeight)
    }
    
    func setOriginSize(_ value: CGSize) {
        originSize = value
    }
    
    func setOriginSizeWithoutSafeArea(_ value: CGSize) {
        originSizeWithoutSafeArea = value
    }
    
    func setSafeAreaHeight(top: CGFloat, bottom: CGFloat) {
        safeAreaHeight = (top: top, bottom: bottom)
    }
    
    func setScreenSize(_ value: CGSize) {
        screenSize = value
    }
    
    func setCurrentCoordinates(_ coordinates: CGPoint) {
        currentCoordinates = coordinates
    }
    
    func setSelectedRowName(_ rowName: RowName?) {
        selectedRowName = rowName
    }
}
