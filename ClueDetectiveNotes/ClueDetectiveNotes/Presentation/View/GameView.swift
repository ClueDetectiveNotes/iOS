//
//  GameView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    @EnvironmentObject private var optionStore: OptionStore
    @StateObject private var sheetStore = SheetStore()
    @StateObject private var controlBarStore = ControlBarStore()
    private let gameSettingIntent: GameSettingIntent
    private let geometryIntent: GeometryIntent
    private let optionIntent: OptionIntent
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(
        gameSettingIntent: GameSettingIntent,
        geometryIntent: GeometryIntent,
        optionIntent: OptionIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.geometryIntent = geometryIntent
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ClassicSheetView(
                sheetStore: sheetStore,
                geometryIntent: geometryIntent
            )
//            VintageSheetView(
//                sheetStore: sheetStore,
//                geometryIntent: geometryIntent
//            )
            .overlay {
                if !sheetStore.isVisibleScreen {
                    privacyScreen
                }
            }
                
            if sheetStore.isShowingMarkerControlBar {
                MarkerControlBarView(
                    optionStore: optionStore,
                    sheetStore: sheetStore,
                    controlBarStore: controlBarStore
                )
            }
            
            ControlBarView(
                sheetStore: sheetStore,
                controlBarStore: controlBarStore,
                gameSettingIntent: gameSettingIntent,
                optionIntent: optionIntent
            )
        }
        .overlay {
            GeometryReader { proxy in
                Color.clear // safeArea 포함한 크기
                    .onAppear {
                        geometryIntent.setOriginSize(
                            screenSize: proxy.size,
                            safeAreaHeight: (safeAreaInsets.top, safeAreaInsets.bottom)
                        )
                    }
            }
        }
    }
    
    var privacyScreen: some View {
        Color.gray.opacity(optionStore.privacyScreenOpacity)
            .overlay {
                Image(systemName: "eye.slash")
                    .font(.largeTitle)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    GameView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()),
        geometryIntent: GeometryIntent(geometryStore: GeometryStore()),
        optionIntent: OptionIntent(optionStore: OptionStore())
    )
    .environmentObject(GeometryStore(screenSize: .init(width: 375, height: 667)))
    .environmentObject(GameSettingStore())
}
