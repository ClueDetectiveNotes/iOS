//
//  GeometryInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/5/24.
//

import Foundation

struct GeometryInteractor {
    private var geometryStore: GeometryStore
    
    init(geometryStore: GeometryStore) {
        self.geometryStore = geometryStore
    }
    
    func setOriginSize(screenSize: CGSize, safeAreaHeight: (top: CGFloat, bottom: CGFloat)) {
        geometryStore.setSafeAreaHeight(top: safeAreaHeight.top, bottom: safeAreaHeight.bottom)
        
        if geometryStore.originSize == .zero {
            geometryStore.setOriginSize(
                CGSize(
                    width: screenSize.width,
                    height: screenSize.height
                )
            )
            
            geometryStore.setScreenSize(
                CGSize(
                    width: screenSize.width,
                    height: screenSize.height - (safeAreaHeight.top + safeAreaHeight.bottom)
                )
            )
            
            geometryStore.setOriginSizeWithoutSafeArea(
                CGSize(
                    width: screenSize.width,
                    height: screenSize.height - (safeAreaHeight.top + safeAreaHeight.bottom)
                )
            )
        }
    }
    
    func isClickCoveredByControlBars() -> Bool {
        let coveredBottomY = geometryStore.originSize.height - (geometryStore.controlBarHeight + geometryStore.safeAreaHeight.bottom)
        let coveredTopY = coveredBottomY - geometryStore.markerControlBarHeight - 40
        let currentY = geometryStore.currentCoordinates?.y ?? 0.0
        
        geometryStore.setSelectedRowName(nil)
        
        return coveredTopY...coveredBottomY ~= currentY
    }
    
    func clickCell(currentCoordinates: CGPoint, currentRowName: RowName) {
        geometryStore.setCurrentCoordinates(currentCoordinates)
        geometryStore.setSelectedRowName(currentRowName)
    }
}
