//
//  PlayerSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerSettingView: View {
    @EnvironmentObject private var settingStore: SettingStore
    @StateObject private var keyboardObserver = KeyboardObserver()
    private var settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
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
                    settingInteractor: settingInteractor
                )
                
                Spacer()
                    .frame(height: 50)
                
                PlayerNameFieldListView()
                
                Spacer()
                
                if !keyboardObserver.isKeyboardVisible {
                    if !settingInteractor.isValidPlayerNames() {
                        Text("이름이 입력되지 않았거나, 중복된 이름이 있습니다.")
                            .foregroundStyle(.gray)
                            .ignoresSafeArea(.keyboard)
                    }
                    
                    NextButtonView(
                        settingInteractor: settingInteractor
                    )
                    
                    Spacer()
                }
            }
        }
        .padding(0)
    }
}

private struct StepperView: View {
    @EnvironmentObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
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
            
            Text("\(settingStore.playerCount)")
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
    @EnvironmentObject private var settingStore: SettingStore
    
    var body: some View {
        List {
            ForEach(settingStore.playerNames.indices, id: \.self) { index in
                NameField(index: index)
            }
        }
        .listStyle(.inset)
        .listRowSpacing(10)
    }
}

private struct NameField: View {
    @EnvironmentObject private var settingStore: SettingStore
    @State private var tempName = ""
    private var index: Int
    
    init(
        index: Int
    ) {
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
    @EnvironmentObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        NavigationLink {
            PlayerDetailSettingView(
                settingInteractor: settingInteractor
            )
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
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
        settingInteractor: SettingInteractor(settingStore: SettingStore())
    )
    .environmentObject(SettingStore())
}
