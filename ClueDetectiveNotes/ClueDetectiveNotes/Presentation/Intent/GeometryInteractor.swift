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
    
    func setOriginSize(screenSize: CGSize, safeAreaHeight: CGFloat) {
        if geometryStore.originSize == .zero {
            geometryStore.setOriginSize(
                CGSize(
                    width: screenSize.width,
                    height: screenSize.height - safeAreaHeight
                )
            )
            geometryStore.setScreenSize(
                CGSize(
                    width: screenSize.width,
                    height: screenSize.height - safeAreaHeight
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
                    width: geometryStore.originSize.height,
                    height: geometryStore.originSize.width
                )
            )
        } else {
            geometryStore.setScreenSize(geometryStore.originSize)
        }
    }
}

enum DeviceOrientation {
    case landscape // 가로
    case portrait // 세로
}
