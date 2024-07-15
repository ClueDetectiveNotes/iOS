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
        let screenSize = geometryStore.screenSize
        let controlBarsHeight = geometryStore.controlBarHeight + geometryStore.markerControlBarHeight + 10
        let currentY = geometryStore.currentCoordinates?.y ?? 0.0
        
        return (screenSize.height - controlBarsHeight)...screenSize.height ~= currentY
    }
    
    func clickCell(currentCoordinates: CGPoint, currentRowName: RowName) {
        geometryStore.setCurrentCoordinates(currentCoordinates)
        geometryStore.setSelectedRowName(currentRowName)
    }
    
    func changeDeviceOrientation(_ orientation: DeviceOrientation) {
        if orientation == .landscape {
            geometryStore.setScreenSize(
                CGSize(
                    width: geometryStore.originSizeWithoutSafeArea.height,
                    height: geometryStore.originSizeWithoutSafeArea.width
                )
            )
        } else {
            geometryStore.setScreenSize(geometryStore.originSizeWithoutSafeArea)
        }
    }
}

enum DeviceOrientation {
    case landscape // 가로
    case portrait // 세로
}
