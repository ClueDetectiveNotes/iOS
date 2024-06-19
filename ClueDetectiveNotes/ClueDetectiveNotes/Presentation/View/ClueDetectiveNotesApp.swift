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
    
    var body: some Scene {
        WindowGroup {
            PlayerSettingView()
//            GameView(
//                settingStore: settingStore,
//                settingInteractor: SettingInteractor(settingStore: settingStore)
//            )
        }
    }
}
