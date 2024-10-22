//
//  ControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

import SwiftUI

struct ControlBarView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    private let controlBarIntent: ControlBarIntent
    private let gameSettingIntent: GameSettingIntent
    
    init(
        sheetStore: SheetStore,
        gameSettingIntent: GameSettingIntent
    ) {
        self.sheetStore = sheetStore
        self.controlBarIntent = ControlBarIntent(sheetStore: sheetStore)
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        HStack(spacing: 30) {
            
            // Undo
            Button(
                action: {
                    controlBarIntent.clickUndo()
                },
                label: {
                    Image(systemName: "arrow.uturn.left")
                        .foregroundStyle(Color("blue1"))
                }
            )
            
            // Redo
            Button(
                action: {
                    controlBarIntent.clickRedo()
                },
                label: {
                    Image(systemName: "arrow.uturn.right")
                        .foregroundStyle(Color("blue1"))
                }
            )
            
            // Clear
            Button(
                action: {
                    controlBarIntent.clickClearButton()
                },
                label: {
                    Image(systemName: "eraser")
                        .foregroundStyle(Color("blue1"))
                }
            )
            
            // Cancel
            Button(
                action: {
                    controlBarIntent.clickCancelButton()
                },
                label: {
                    Image(systemName: "square.dashed")
                        .foregroundStyle(Color("blue1"))
                }
            )
            
            Spacer()
            
            Button(
                action: {
                    // 화면 가리기
                    controlBarIntent.clickVisibleButton()
                },
                label: {
                    Image(systemName: sheetStore.isVisibleScreen ? "eye" : "eye.slash")
                        .foregroundStyle(Color("blue1"))
                }
            )
            
            // 더보기
            MoreMenuView(gameSettingIntent: gameSettingIntent)
            
        }
        .padding(10)
        .padding(.horizontal, 20)
        .frame(height: geometryStore.controlBarHeight)
        .background()
        .clipped()
        .shadow(
            radius: sheetStore.isDisplayMarkerControlBar ? 0 : 4,
            x: 0,
            y: sheetStore.isDisplayMarkerControlBar ? 0 : -7
        )
    }
}

#Preview {
    ControlBarView(
        sheetStore: SheetStore(), 
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore())
    )
        .environmentObject(GeometryStore())
}
