//
//  MoreMenuView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/3/24.
//

import SwiftUI

struct MoreMenuView: View {
    @ObservedObject private var sheetStore: SheetStore
    @ObservedObject private var controlBarStore: ControlBarStore
    private let gameSettingIntent: GameSettingIntent
    private let optionIntent: OptionIntent
    private let controlBarIntent: ControlBarIntent
    
    @State private var wantsToGoHome: Bool = false
    @State private var wantsToRestartGame: Bool = false
    @State private var testBool: Bool = false
    
    init(
        sheetStore: SheetStore,
        controlBarStore: ControlBarStore,
        gameSettingIntent: GameSettingIntent,
        optionIntent: OptionIntent,
        controlBarIntent: ControlBarIntent
    ) {
        self.sheetStore = sheetStore
        self.controlBarStore = controlBarStore
        self.gameSettingIntent = gameSettingIntent
        self.optionIntent = optionIntent
        self.controlBarIntent = controlBarIntent
    }
    
    var body: some View {
        //작성된 순서 반대로 보임
        Menu {
            // 정답칸 숨기기
//            Button(
//                action: {
//                    controlBarIntent.clickHiddenAnswer()
//                },
//                label: {
//                    Text("정답칸 숨기기")
//                }
//            )
            Toggle("정답칸 숨기기", isOn: $sheetStore.isHiddenAnswer)
            
            // 옵션
            Button(
                action: {
                    controlBarIntent.clickOption()
                },
                label: {
                    Text("설정")
                }
            )
            
            // 다시하기
            Button {
                controlBarIntent.clickRestartGameInMoreMenu()
            } label: {
                Text("다시하기")
            }
            
            // 홈으로
            Button {
                controlBarIntent.clickGoHomeInMoreMenu()
            } label: {
                Text("홈으로")
            }
            
        } label: {
            Button(
                action: {
                    //
                },
                label: {
                    Image(systemName: "ellipsis")
                        .frame(height: 20)
                }
            )
        }
    }
}

#Preview {
    MoreMenuView(
        sheetStore: SheetStore(), 
        controlBarStore: ControlBarStore(),
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()),
        optionIntent: OptionIntent(optionStore: OptionStore()),
        controlBarIntent: ControlBarIntent(
            sheetStore: SheetStore(),
            controlBarStore: ControlBarStore()
        )
    )
}
