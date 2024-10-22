//
//  PlayerSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerSettingView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    @StateObject private var keyboardObserver = KeyboardObserver()
    private let gameSettingIntnet: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntnet = gameSettingIntent
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 44)
                
                TitleView(
                    title: "플레이어 설정",
                    description: "게임에 참여하는 인원 수와 이름을 설정해주세요."
                )
                
                Spacer()
                    .frame(height: 50)
                
                StepperView(
                    gameSettingIntent: gameSettingIntnet
                )
                
                Spacer()
                    .frame(height: 50)
                
                PlayerNameFieldListView(
                    gameSettingIntent: gameSettingIntnet
                )
                
                Spacer()
                
                if !keyboardObserver.isKeyboardVisible {
                    if gameSettingStore.isDisablePlayerSettingNextButton {
                        Text("이름이 입력되지 않았거나, 중복된 이름이 있습니다.")
                            .foregroundStyle(Color("subText"))
                            .ignoresSafeArea(.keyboard)
                    }
                    
                    NextButtonView(
                        gameSettingIntent: gameSettingIntnet
                    )
                    
                    Spacer()
                }
            }
        }
        .padding(0)
    }
}

private struct StepperView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        HStack {
            Button(
                action: {
                    gameSettingIntent.clickMinusButton()
                },
                label: {
                    Image(systemName: "minus")
                        .frame(width: 25, height: 17)
                        .foregroundStyle(Color("blue1"))
                }
            )
            .disabled(gameSettingStore.isDisabledMinusButton)
            .buttonStyle(.bordered)
            
            Text("\(gameSettingStore.gameGameSetting.playerCount)")
                .font(.title)
                .foregroundStyle(Color("black1"))
                .padding([.leading, .trailing])
            
            Button(
                action: {
                    gameSettingIntent.clickPlusButton()
                },
                label: {
                    Image(systemName: "plus")
                        .frame(width: 25, height: 17)
                        .foregroundStyle(Color("blue1"))
                }
            )
            .disabled(gameSettingStore.isDisabledPlusButton)
            .buttonStyle(.bordered)
        }
    }
}

private struct PlayerNameFieldListView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        List {
            ForEach(gameSettingStore.gameGameSetting.playerNames.indices, id: \.self) { index in
                NameField(
                    gameSettingIntent: gameSettingIntent,
                    index: index
                )
            }
        }
        .listStyle(.inset)
        .listRowSpacing(10)
    }
}

private struct NameField: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    @State private var tempName = ""
    private let gameSettingIntent: GameSettingIntent
    private let index: Int
    
    init(
        gameSettingIntent: GameSettingIntent,
        index: Int
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.index = index
    }
    
    var body: some View {
        VStack {
            TextField(
                "Player \(index+1) Name",
                text: index < gameSettingStore.gameGameSetting.playerNames.count
                ? $gameSettingStore.gameGameSetting.playerNames[index]
                : $tempName
            )
            .onChange(
                of: index < gameSettingStore.gameGameSetting.playerNames.count
                ? gameSettingStore.gameGameSetting.playerNames[index]
                : "" ,
                perform: { newName in
                    gameSettingIntent.setPlayerName(index: index, name: newName)
                }
            )
            .foregroundStyle(Color("black1"))
        }
    }
}

private struct NextButtonView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        NavigationLink {
            PlayerDetailSettingView(
                gameSettingIntent: gameSettingIntent
            )
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
            .foregroundStyle(Color("button_white"))
        }
        .buttonStyle(.borderedProminent)
        .foregroundStyle(Color("blue1"))
        .disabled(gameSettingStore.isDisablePlayerSettingNextButton)
    }
}

#Preview {
    PlayerSettingView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore())
    )
    .environmentObject(GameSettingStore())
}
