//
//  DeviceInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/5/24.
//

import Foundation

struct DeviceInteractor {
    private var deviceStore: DeviceStore
    
    init(deviceStore: DeviceStore) {
        self.deviceStore = deviceStore
    }
    
    func changeDeviceOrientation(_ screenSize: CGSize) {
        if deviceStore.originSize == .zero {
            deviceStore.setOriginSize(screenSize)
            deviceStore.setScreenSize(screenSize)
        } else {
            if deviceStore.originSize.height == screenSize.width &&
                deviceStore.originSize.width == screenSize.height {
                deviceStore.setScreenSize(screenSize)
            } else {
                deviceStore.setScreenSize(deviceStore.originSize)
            }
        }
    }
}
