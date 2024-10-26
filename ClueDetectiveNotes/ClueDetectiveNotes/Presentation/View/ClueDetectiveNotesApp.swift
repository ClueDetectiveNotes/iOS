//
//  ClueDetectiveNotesApp.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

@main
struct ClueDetectiveNotesApp: App {
    @AppStorage("screenMode") private var screenMode: ScreenMode = .system
    // 위의 키에 값이 없을 때만 system이 들어가고, 이미 값이 있을 때는 있던 값으로 들어감
    
    @StateObject private var gameSettingStore = GameSettingStore()
    @StateObject private var geometryStore = GeometryStore()
    
    var body: some Scene {
        WindowGroup {
            PlayerSettingView(
                gameSettingIntent: GameSettingIntent(gameSettingStore: gameSettingStore)
            )
            .environmentObject(geometryStore)
            .environmentObject(gameSettingStore)
            .preferredColorScheme(screenMode.getColorScheme())
        }
    }
}
