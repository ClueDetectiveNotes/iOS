//
//  PlayerDetailSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerDetailSettingView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    private let optionIntent: OptionIntent
    
    init(
        gameSettingIntent: GameSettingIntent,
        optionIntent: OptionIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TitleView(
                    title: "플레이어 설정",
                    description: "자신을 선택하고, 플레이 순서에 맞게 정렬해주세요."
                )
                
                Spacer()
                    .frame(height: 50)
                
                PlayerNameListView(
                    gameSettingIntent: gameSettingIntent
                )
                
                NextButtonView(
                    gameSettingIntent: gameSettingIntent, 
                    optionIntent: optionIntent
                )
                
                Spacer()
            }
        }
    }
}

private struct PlayerNameListView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        List {
            ForEach(gameSettingStore.gameGameSetting.playerNames, id: \.self) { playerName in
                HStack {
                    Image(
                        systemName: gameSettingStore.gameGameSetting.selectedPlayer == playerName
                        ? "checkmark.circle.fill"
                        : "circle"
                    )
                    .foregroundStyle(Color("blue1"))
                    
                    Text("\(playerName)")
                        .foregroundStyle(Color("black1"))
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    gameSettingIntent.selectUser(name: playerName)
                }
            }.onMove { (source: IndexSet, destination: Int) in
                gameSettingIntent.reorderPlayer(
                    source: source,
                    destination: destination
                )
            }
        }
        .environment(\.editMode, .constant(.active))
        .listStyle(.inset)
        .listRowSpacing(10)
    }
}

private struct NextButtonView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    private let optionIntent: OptionIntent
    
    init(
        gameSettingIntent: GameSettingIntent,
        optionIntent: OptionIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        NavigationLink {
            if gameSettingStore.gameGameSetting.publicCardsCount > 0 {
                PublicCardsSettingView(
                    gameSettingIntent: gameSettingIntent, 
                    optionIntent: optionIntent
                )
            } else {
                MyCardsSettingView(
                    gameSettingIntent: gameSettingIntent, 
                    optionIntent: optionIntent
                )
            }
        } label: {
            Text("다음")
                .frame(maxWidth: 250)
                .frame(height: 40)
                .foregroundStyle(Color("button_white"))
        }
        .buttonStyle(.borderedProminent)
        .foregroundStyle(Color("blue1"))
        .disabled(gameSettingStore.isDisablePlayerDetailSettingNextButton)
        .simultaneousGesture(TapGesture().onEnded({ _ in
            gameSettingIntent.initGame()
        }))
    }
}

#Preview {
    PlayerDetailSettingView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()), 
        optionIntent: OptionIntent(optionStore: OptionStore())
    )
    .environmentObject(GameSettingStore())
}
