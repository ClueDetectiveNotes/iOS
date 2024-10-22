//
//  MoreMenuView.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/3/24.
//

import SwiftUI

struct MoreMenuView: View {
    let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        //작성된 순서 반대로 보임
        Menu {
            Button(
                action: {
                    
                },
                label: {
                    Text("정답칸 보이기")
                }
            )
            
            Button(
                action: {
                    //
                },
                label: {
                    Text("옵션")
                }
            )
            
            NavigationLink {
                PlayerSettingView(
                    gameSettingIntent: gameSettingIntent
                )
                .navigationBarBackButtonHidden()
            } label: {
                Text("다시하기")
            }
            .simultaneousGesture(TapGesture().onEnded {
                gameSettingIntent.initGame()
            })
            
            Button(
                action: {
                    // 홈으로
                },
                label: {
                    Text("홈")
                }
            )
            
        } label: {
            Button(
                action: {
                    // 세팅 화면
                },
                label: {
                    Image(systemName: "ellipsis")
                }
            )
        }
    }
}

#Preview {
    MoreMenuView(gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()))
}
