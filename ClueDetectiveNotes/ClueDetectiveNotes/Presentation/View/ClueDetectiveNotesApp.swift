//
//  ClueDetectiveNotesApp.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

@main
struct ClueDetectiveNotesApp: App {
    @StateObject private var settingStore = SettingStore()
    @StateObject private var deviceStore = DeviceStore()
    
    var body: some Scene {
        WindowGroup {
            PlayerSettingView(
                settingStore: settingStore,
                settingInteractor: SettingInteractor(settingStore: settingStore)
            )
            .environmentObject(deviceStore)
        }
    }
}
