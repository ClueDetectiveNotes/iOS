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
    
    var body: some Scene {
        WindowGroup {
            PlayerSettingView(
                gameSettingInteractor: GameSettingInteractor(gameSettingStore: gameSettingStore)
            )
            .environmentObject(geometryStore)
            .environmentObject(gameSettingStore)
        }
    }
}
