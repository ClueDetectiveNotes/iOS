//
//  PlayerDetailSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerDetailSettingView: View {
    private var settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
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
                    settingInteractor: settingInteractor
                )
                
                NextButtonView(
                    settingInteractor: settingInteractor)
                
                Spacer()
            }
        }
    }
}

private struct PlayerNameListView: View {
    @EnvironmentObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
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
    @EnvironmentObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        NavigationLink {
            if settingInteractor.isExistPublicCard() {
                PublicCardsSettingView(
                    settingInteractor: settingInteractor
                )
            } else {
                MyCardsSettingView(
                    settingInteractor: settingInteractor
                )
            }

        } label: {
            Text("다음")
                .frame(maxWidth: 250)
                .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
        .disabled(settingInteractor.isEmptySelectedPlayer())
        .simultaneousGesture(TapGesture().onEnded({ _ in
            settingInteractor.clickPlayerDetailSettingNextButton()
        }))
    }
}

#Preview {
    PlayerDetailSettingView(
        settingInteractor: SettingInteractor(settingStore: SettingStore())
    )
    .environmentObject(SettingStore())
}
