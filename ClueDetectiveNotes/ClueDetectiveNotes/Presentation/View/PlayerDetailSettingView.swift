//
//  PlayerDetailSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerDetailSettingView: View {
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
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
                    gameSettingInteractor: gameSettingInteractor
                )
                
                NextButtonView(
                    gameSettingInteractor: gameSettingInteractor
                )
                
                Spacer()
            }
        }
    }
}

private struct PlayerNameListView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
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
                    gameSettingInteractor.selectUser(name: playerName)
                }
            }.onMove { (source: IndexSet, destination: Int) in
                gameSettingInteractor.reorderPlayer(
                    source: source,
                    destination: destination
                )
            }
        }
        .environment(\.editMode, .constant(.active))
        .listStyle(.inset)
        .listRowSpacing(10)
        //.listRowSeparatorTint(<#T##color: Color?##Color?#>)
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
            if gameSettingStore.gameGameSetting.publicCardsCount > 0 {
                PublicCardsSettingView(
                    gameSettingInteractor: gameSettingInteractor
                )
            } else {
                MyCardsSettingView(
                    gameSettingInteractor: gameSettingInteractor
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
            gameSettingInteractor.initGame()
        }))
    }
}

#Preview {
    PlayerDetailSettingView(
        gameSettingInteractor: GameSettingInteractor(gameSettingStore: GameSettingStore())
    )
    .environmentObject(GameSettingStore())
}
