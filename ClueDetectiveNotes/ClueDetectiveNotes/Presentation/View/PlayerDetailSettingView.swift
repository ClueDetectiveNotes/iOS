//
//  PlayerDetailSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerDetailSettingView: View {
    @ObservedObject private var settingStore: SettingStore
    @State private var selectedPlayer: String = ""
    private var settingInteractor: SettingInteractor
    
    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
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
                    settingStore: settingStore,
                    settingInteractor: settingInteractor
                )
                
                NextButtonView(
                    settingStore: settingStore,
                    settingInteractor: settingInteractor)
            }
        }
    }
}

private struct PlayerNameListView: View {
    @ObservedObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        List {
            ForEach(settingStore.playerNames, id: \.self) { playerName in
                HStack {
                    Image(
                        systemName: settingInteractor.isSelectedPlayer(playerName)
                        ? "checkmark.circle.fill"
                        : "circle"
                    )
                        .foregroundStyle(.blue)
                    Text("\(playerName)")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    settingInteractor.selectPlayer(playerName)
                }
            }.onMove { (source: IndexSet, destination: Int) in
                settingStore.playerNames.move(fromOffsets: source, toOffset: destination)
                print(settingStore.playerNames)
            }
        }
        .environment(\.editMode, .constant(.active))
        .listStyle(.inset)
        .listRowSpacing(10)
    }
}

private struct NextButtonView: View {
    @ObservedObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        NavigationLink {
            GameView(
                settingStore: settingStore,
                settingInteractor: settingInteractor
            )
            .navigationBarBackButtonHidden()
        } label: {
            Text("다음")
                .frame(maxWidth: 250)
                .frame(height: 40)
        }
        .navigationDestination(for: String.self) { _ in
            GameView(
                settingStore: settingStore,
                settingInteractor: settingInteractor
            )
        }
        .buttonStyle(.borderedProminent)
        .disabled(settingInteractor.isEmptySelectedPlayer())
        .simultaneousGesture(TapGesture().onEnded({ _ in
            settingInteractor.clickPlayerDetailSettingNextButton()
        }))
    }
}

struct PlayerView: View {
    
    var body: some View {
        Text("까꽁")
    }
}

#Preview {
    PlayerDetailSettingView(
        settingStore: SettingStore(),
        settingInteractor: SettingInteractor(settingStore: SettingStore())
    )
}
