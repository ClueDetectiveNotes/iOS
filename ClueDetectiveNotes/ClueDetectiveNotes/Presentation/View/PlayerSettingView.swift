//
//  PlayerSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerSettingView: View {
    @ObservedObject private var settingStore: SettingStore
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
                Spacer()
                    .frame(height: 44)
                
                TitleView(
                    title: "플레이어 설정",
                    description: "게임에 참여하는 인원 수와 이름을 설정해주세요."
                )
                
                Spacer()
                    .frame(height: 50)
                
                StepperView(
                    settingStore: settingStore,
                    settingInteractor: settingInteractor
                )
                
                Spacer()
                    .frame(height: 50)
                
                PlayerNameFieldListView(settingStore: settingStore)
                
                Spacer()
                
                
                if !settingInteractor.isValidPlayerNames() {
                    Text("이름이 입력되지 않았거나, 중복된 이름이 있습니다.")
                        .foregroundStyle(.gray)
                }
                
                NextButtonView(
                    settingStore: settingStore,
                    settingInteractor: settingInteractor
                )
            }
        }
        .padding(0)
    }
}

private struct StepperView: View {
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
        HStack {
            Button(
                action: {
                    settingInteractor.clickMinusButton()
                },
                label: {
                    Image(systemName: "minus")
                        .frame(width: 25, height: 17)
                }
            )
            .disabled(settingStore.isDisabledMinusButton)
            .buttonStyle(.bordered)
            
            Text("\(settingStore.count)")
                .font(.title)
                .padding([.leading, .trailing])
            
            Button(
                action: {
                    settingInteractor.clickPlusButton()
                },
                label: {
                    Image(systemName: "plus")
                        .frame(width: 25, height: 17)
                }
            )
            .disabled(settingStore.isDisabledPlusButton)
            .buttonStyle(.bordered)
        }
    }
}

private struct PlayerNameFieldListView: View {
    @ObservedObject private var settingStore: SettingStore
    
    init(settingStore: SettingStore) {
        self.settingStore = settingStore
    }
    
    var body: some View {
        List {
            ForEach(settingStore.playerNames.indices, id: \.self) { index in
                NameField(settingStore: settingStore, index: index)
            }
        }
        .listStyle(.inset)
        .listRowSpacing(10)
    }
}

private struct NameField: View {
    @ObservedObject private var settingStore: SettingStore
    @State var tempName = ""
    var index: Int
    
    init(
        settingStore: SettingStore, 
        index: Int
    ) {
        self.settingStore = settingStore
        self.index = index
    }
    
    var body: some View {
        VStack {
            TextField(
                "Player \(index+1) Name",
                text: index < settingStore.playerNames.count 
                ? $settingStore.playerNames[index]
                : $tempName
            )
        }
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
            PlayerDetailSettingView(
                settingStore: settingStore,
                settingInteractor: settingInteractor
            )
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
        }
        .navigationDestination(for: [String].self) { _ in
            PlayerDetailSettingView(
                settingStore: settingStore,
                settingInteractor: settingInteractor
            )
        }
        .buttonStyle(.borderedProminent)
        .disabled(!settingInteractor.isValidPlayerNames())
        .simultaneousGesture(TapGesture().onEnded({ _ in
            settingInteractor.clickPlayerSettingNextButton()
        }))
    }
}

#Preview {
    PlayerSettingView(
        settingStore: SettingStore(),
        settingInteractor: SettingInteractor(settingStore: SettingStore())
    )
}
