//
//  PlayerDetailSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerDetailSettingView: View {
    @State private var playerNames: [String]
    @State private var selectedPlayer: String = ""
    
    init(playerNames: [String]) {
        self.playerNames = playerNames
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TitleView()
                
                Spacer()
                    .frame(height: 50)
                
                List {
                    ForEach(playerNames, id: \.self) { playerName in
                        HStack {
                            Image(systemName: selectedPlayer == playerName ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(.blue)
                            Text("\(playerName)")
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedPlayer = playerName
                        }
                    }.onMove { (source: IndexSet, destination: Int) in
                        self.playerNames.move(fromOffsets: source, toOffset: destination)
                        print(playerNames)
                    }
                }
                .environment(\.editMode, .constant(.active))
                .listStyle(.inset)
                .listRowSpacing(10)
                
                NavigationLink {
                    PlayerView(name: "111")
                } label: {
                    Text("다음")
                        .frame(maxWidth: 200)
                        .frame(height: 40)
                }
                .navigationDestination(for: String.self) { name in
                    PlayerView(name: "111")
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedPlayer.isEmpty ? true : false)
            }
        }
    }
}

private struct TitleView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("플레이어 설정")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            
            Spacer()
                .frame(height: 10)
            
            HStack {
                Text("자신을 선택하고, 플레이 순서에 맞게 정렬해주세요.")
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
        .padding()
    }
}

struct PlayerView: View {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        Text("d")
    }
    
}

#Preview {
    PlayerDetailSettingView(playerNames: ["다산","메리","코코"])
}
