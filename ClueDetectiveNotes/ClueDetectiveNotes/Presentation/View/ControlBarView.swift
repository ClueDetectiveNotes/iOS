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
    @ObservedObject private var controlBarStore: ControlBarStore
    private let gameSettingIntent: GameSettingIntent
    private let optionIntent: OptionIntent
    private let controlBarIntent: ControlBarIntent
    
    init(
        sheetStore: SheetStore,
        controlBarStore: ControlBarStore,
        gameSettingIntent: GameSettingIntent,
        optionIntent: OptionIntent
    ) {
        self.sheetStore = sheetStore
        self.controlBarStore = controlBarStore
        self.gameSettingIntent = gameSettingIntent
        self.optionIntent = optionIntent
        self.controlBarIntent = ControlBarIntent(
            sheetStore: sheetStore,
            controlBarStore: controlBarStore
        )
    }
    
    var body: some View {
        HStack(spacing: 25) {
            
            // Lock
            Image(
                systemName: sheetStore.sheet.isCellsLocked
                ? "lock"
                : "lock.open"
            )
            .frame(width: 15)
            .foregroundStyle(Color("blue1"))
            .simultaneousGesture(LongPressGesture().onEnded ({ _ in
                controlBarIntent.longPressLockButton()
            }))
            .simultaneousGesture(TapGesture().onEnded({ _ in
                controlBarIntent.tapLockButton()
            }))
            
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
            
            // Skip Previous
            Button(
                action: {
                    controlBarIntent.clickSkipPrevious()
                },
                label: {
                    Image(systemName: "backward.end")
                        .foregroundStyle(
                            sheetStore.sheet.isInferenceMode()
                            ? Color("blue1")
                            : Color("darkgray1")
                        )
                }
            )
            .disabled(!sheetStore.sheet.isInferenceMode())
            
            // Skip Next
            Button(
                action: {
                    controlBarIntent.clickSkipNext()
                },
                label: {
                    Image(systemName: "forward.end")
                        .foregroundStyle(
                            sheetStore.sheet.isInferenceMode()
                            ? Color("blue1")
                            : Color("darkgray1")
                        )
                }
            )
            .disabled(!sheetStore.sheet.isInferenceMode())
            
//            // Clear
//            Button(
//                action: {
//                    controlBarIntent.clickClearButton()
//                },
//                label: {
//                    Image(systemName: "eraser")
//                        .foregroundStyle(Color("blue1"))
//                }
//            )
//            
//            // Cancel
//            Button(
//                action: {
//                    controlBarIntent.clickCancelButton()
//                },
//                label: {
//                    Image(systemName: "square.dashed")
//                        .foregroundStyle(Color("blue1"))
//                }
//            )
            
            Spacer()
            
            Button(
                action: {
                    // 화면 가리기
                    controlBarIntent.clickVisibleButton()
                },
                label: {
                    Image(
                        systemName: sheetStore.isVisibleScreen
                        ? "eye"
                        : "eye.slash"
                    )
                    .foregroundStyle(Color("blue1"))
                }
            )
            
            // 더보기
            MoreMenuView(
                sheetStore: sheetStore,
                controlBarStore: controlBarStore,
                gameSettingIntent: gameSettingIntent,
                optionIntent: optionIntent,
                controlBarIntent: controlBarIntent
            )
            
        }
        .padding(10)
        .padding(.horizontal, 20)
        .frame(height: geometryStore.controlBarHeight)
        .background()
        .clipped()
        .shadow(
            radius: sheetStore.isShowingMarkerControlBar ? 0 : 4,
            x: 0,
            y: sheetStore.isShowingMarkerControlBar ? 0 : -7
        )
        .sheet(isPresented: $controlBarStore.isShowingOptionView) {
            OptionView(optionIntent: optionIntent)
        }
        .alert(
            "세팅 화면으로 돌아가시겠습니까?",
            isPresented: $controlBarStore.isShowingRestartGameAlert
        ) {
            Button("확인") {
                controlBarIntent.restartGame()
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("플레이어 정보를 제외한 게임 진행 상황이 사라집니다.")
        }
        .navigationDestination(isPresented: $controlBarStore.wantsToRestartGame) {
            PlayerSettingView(
                gameSettingIntent: gameSettingIntent,
                optionIntent: optionIntent
            )
            .navigationBarBackButtonHidden()
            .toolbar {
                Text("")
            }
        }
        .alert(
            "홈으로 돌아가시겠습니까?",
            isPresented: $controlBarStore.isShowingToHomeAlert
        ) {
            Button("확인") {
                controlBarIntent.goHome()
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("현재 게임 진행 상황이 모두 사라집니다.")
        }
        .navigationDestination(isPresented: $controlBarStore.wantsToGoHome) {
            HomeView(
                gameSettingIntent: gameSettingIntent,
                optionIntent: optionIntent
            )
            .navigationBarBackButtonHidden()
        }
    }
}



#Preview {
    ControlBarView(
        sheetStore: SheetStore(), 
        controlBarStore: ControlBarStore(),
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()), 
        optionIntent: OptionIntent(optionStore: OptionStore())
    )
    .environmentObject(GeometryStore())
}
