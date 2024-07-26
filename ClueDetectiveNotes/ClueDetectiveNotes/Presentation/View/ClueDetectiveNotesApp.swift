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
    @StateObject private var geometryStore = GeometryStore()
    
    var body: some Scene {
        WindowGroup {
            PlayerSettingView(
                settingInteractor: SettingInteractor(settingStore: settingStore)
            )
            .environmentObject(geometryStore)
            .environmentObject(settingStore)
        }
    }
}
