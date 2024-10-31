//
//  MoreMenuView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/3/24.
//

import SwiftUI

struct MoreMenuView: View {
    private let gameSettingIntent: GameSettingIntent
    private let optionIntent: OptionIntent
    private let controlBarIntent: ControlBarIntent
    
    init(
        gameSettingIntent: GameSettingIntent,
        optionIntent: OptionIntent,
        controlBarIntent: ControlBarIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.optionIntent = optionIntent
        self.controlBarIntent = controlBarIntent
    }
    
    var body: some View {
        //작성된 순서 반대로 보임
        Menu {
            // 정답칸 보이기
            Button(
                action: {
                    
                },
                label: {
                    Text("정답칸 보이기")
                }
            )
            
            // 옵션
            Button(
                action: {
                    controlBarIntent.clickOption()
                },
                label: {
                    Text("옵션")
                }
            )
            
            // 다시하기
            NavigationLink {
                PlayerSettingView(
                    gameSettingIntent: gameSettingIntent, 
                    optionIntent: optionIntent
                )
                .navigationBarBackButtonHidden()
                .toolbar {
                    Text("")
                }
            } label: {
                Text("다시하기")
            }
            
            // 홈으로
            // TODO: - 게임을 끝내시겠습니까? 얼럿
            NavigationLink {
                HomeView(
                    gameSettingIntent: gameSettingIntent,
                    optionIntent: optionIntent
                )
                .navigationBarBackButtonHidden()
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
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()),
        optionIntent: OptionIntent(optionStore: OptionStore()),
        controlBarIntent: ControlBarIntent(
            sheetStore: SheetStore(),
            controlBarStore: ControlBarStore()
        )
    )
}
