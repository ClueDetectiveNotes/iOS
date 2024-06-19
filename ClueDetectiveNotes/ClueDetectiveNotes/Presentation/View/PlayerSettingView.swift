//
//  PlayerSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/18/24.
//

import SwiftUI

struct PlayerSettingView: View {
    @State private var value = 3
    @State private var playerNames = Array(repeating: "", count: 3)
    let range = 3...6
    
    var body: some View {
        NavigationStack {
            
            VStack {
                TitleView()
                
                Spacer()
                    .frame(height: 50)
                
                HStack {
                    Button(
                        action: {
                            decrementStep()
                        },
                        label: {
                            Image(systemName: "minus")
                                .frame(width: 25, height: 17)
                        }
                    )
                    .disabled(value == 3 ? true : false)
                    .buttonStyle(.bordered)
                    
                    Text("\(value)")
                        .font(.title)
                        .padding([.leading, .trailing])
                    
                    Button(
                        action: {
                            incrementStep()
                        },
                        label: {
                            Image(systemName: "plus")
                                .frame(width: 25, height: 17)
                        }
                    )
                    .disabled(value == 6 ? true : false)
                    .buttonStyle(.bordered)
                }
                
                Spacer()
                    .frame(height: 50)
                
                List {
                    ForEach(playerNames.indices, id: \.self) { index in
                        VStack {
                            TextField(
                                "Player \(index+1) Name",
                                text: $playerNames[index]
                            )
                        }
                    }
                }
                .listStyle(.inset)
                .listRowSpacing(10)
                
                Spacer()
                
                NavigationLink {
                    PlayerDetailSettingView(playerNames: playerNames)
                } label: {
                    Text("다음")
                    .frame(maxWidth: 200)
                    .frame(height: 40)
                }
                .navigationDestination(for: [String].self) { playerNames in
                    PlayerDetailSettingView(playerNames: playerNames)
                }
                .buttonStyle(.borderedProminent)
                .disabled(checkIsEmpty() ? true : false)
            }
        }
        .padding()
    }
    
    func checkIsEmpty() -> Bool {
        var check = false
        for playerName in playerNames {
            if playerName.isEmpty {
                check = true
                break
            }
        }
        return check
    }
    // 이름이 중복된 것은 없는지도 체크해야함ㅋ
    
    func incrementStep() {
        if value < 6 {
            value += 1
            playerNames.append("")
        }
    }
    
    func decrementStep() {
        if value > 3 {
            value -= 1
            playerNames.removeLast()
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
                Text("게임에 참여하는 인원 수와 이름을 설정해주세요.")
                    .foregroundStyle(.gray)
                Spacer()
            }
        }
        .padding()
    }
}

//struct StepperView: View {
//    var body: some View {
//
//    }
//}

#Preview {
    PlayerSettingView()
}
