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
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
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
                    gameSettingInteractor: gameSettingInteractor
                )
                
                Spacer()
                    .frame(height: 50)
                
                PlayerNameFieldListView(
                    gameSettingInteractor: gameSettingInteractor
                )
                
                Spacer()
                
                if !keyboardObserver.isKeyboardVisible {
                    if gameSettingStore.isDisablePlayerSettingNextButton {
                        Text("이름이 입력되지 않았거나, 중복된 이름이 있습니다.")
                            .foregroundStyle(.gray)
                            .ignoresSafeArea(.keyboard)
                    }
                    
                    NextButtonView(
                        gameSettingInteractor: gameSettingInteractor
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
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        HStack {
            Button(
                action: {
                    gameSettingInteractor.clickMinusButton()
                },
                label: {
                    Image(systemName: "minus")
                        .frame(width: 25, height: 17)
                }
            )
            .disabled(gameSettingStore.isDisabledMinusButton)
            .buttonStyle(.bordered)
            
            Text("\(gameSettingStore.gameGameSetting.playerCount)")
                .font(.title)
                .padding([.leading, .trailing])
            
            Button(
                action: {
                    gameSettingInteractor.clickPlusButton()
                },
                label: {
                    Image(systemName: "plus")
                        .frame(width: 25, height: 17)
                }
            )
            .disabled(gameSettingStore.isDisabledPlusButton)
            .buttonStyle(.bordered)
        }
    }
}

private struct PlayerNameFieldListView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        List {
            ForEach(gameSettingStore.gameGameSetting.playerNames.indices, id: \.self) { index in
                NameField(
                    gameSettingInteractor: gameSettingInteractor,
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
    private let gameSettingInteractor: GameSettingInteractor
    private let index: Int
    
    init(
        gameSettingInteractor: GameSettingInteractor,
        index: Int
    ) {
        self.gameSettingInteractor = gameSettingInteractor
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
                    gameSettingInteractor.setPlayerName(index: index, name: newName)
                }
            )
        }
    }
}

private struct NextButtonView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        NavigationLink {
            PlayerDetailSettingView(
                gameSettingInteractor: gameSettingInteractor
            )
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
        .disabled(gameSettingStore.isDisablePlayerSettingNextButton)
    }
}

#Preview {
    PlayerSettingView(
        gameSettingInteractor: GameSettingInteractor(gameSettingStore: GameSettingStore())
    )
    .environmentObject(GameSettingStore())
}
