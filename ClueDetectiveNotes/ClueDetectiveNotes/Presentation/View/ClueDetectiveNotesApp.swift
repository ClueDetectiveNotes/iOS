//
//  ClueDetectiveNotesApp.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

@main
struct ClueDetectiveNotesApp: App {
    @StateObject private var gameSettingStore = GameSettingStore()
    @StateObject private var geometryStore = GeometryStore()
    @StateObject private var optionStore = OptionStore()
    
    var body: some Scene {
        WindowGroup {
            HomeView(
                gameSettingIntent: GameSettingIntent(gameSettingStore: gameSettingStore),
                optionIntent: OptionIntent(optionStore: optionStore)
            )
            .environmentObject(geometryStore)
            .environmentObject(gameSettingStore)
            .environmentObject(optionStore)
            .preferredColorScheme(optionStore.screenMode.getColorScheme())
        }
    }
}
