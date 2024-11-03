//
//  HomeView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/31/24.
//

import SwiftUI

struct HomeView: View {
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
            VStack(spacing: 0) {
                Spacer()
                
                HomeButton(
                    title: "시작",
                    PlayerSettingView(
                        gameSettingIntent: gameSettingIntent,
                        optionIntent: optionIntent
                    )
                )
                
                HomeButton(
                    title: "옵션",
                    OptionView(
                        optionIntent: optionIntent
                    )
                )
                
                HomeButton(
                    title: "도움말",
                    Text("도움말")
                )
                
                HomeButton(
                    title: "About Us",
                    AboutUsView()
                )
                
                Spacer()
                
                Text("버전 1.0")
                    .foregroundStyle(Color("darkgray1"))
                    .padding()
            }
        }.onAppear {
            optionIntent.loadOption()
            gameSettingIntent.resetGame()
        }
    }
}

private struct HomeButton<Destination: View>: View {
    private let title: String
    private let maxWidth: CGFloat
    private let destination: Destination
    
    init(
        title: String,
        maxWidth: CGFloat = 110,
        _ destination: Destination
    ) {
        self.title = title
        self.maxWidth = maxWidth
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(title)
                .frame(maxWidth: maxWidth)
                .frame(height: 40)
                .foregroundStyle(Color("button_white"))
        }
        .buttonStyle(.borderedProminent)
        .foregroundStyle(Color("blue1"))
        .padding(.vertical, 10)
    }
}

private struct AboutUsView: View {
    var body: some View {
        VStack {
            TitleView(
                title: "About Us",
                description: ""
            )
            
            HStack {
                VStack(alignment: .leading) {
                    SubTitleView("개발")
                        .padding(.vertical, 10)
                    
                    HStack {
                        Text("AOS")
                            .monospaced()
                        Text("| Kim Eunu")
                    }
                    .padding(.vertical, 7)
                    
                    HStack {
                        Text("iOS")
                            .monospaced()
                        Text("| Jo Sungmi")
                    }
                    .padding(.vertical, 7)
                    
                    HStack {
                        Text("iOS")
                            .monospaced()
                        Text("| Kim Yena")
                    }
                    .padding(.vertical, 7)
                }
                .padding()
                
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()),
        optionIntent: OptionIntent(optionStore: OptionStore())
    )
}
