//
//  HomeView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/31/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var optionStore: OptionStore
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
                    title: "설정",
                    OptionView(
                        optionIntent: optionIntent
                    )
                )
                
                HomeButton(
                    title: "도움말",
                    HelpView()
                )
                
                HomeButton(
                    title: "About Us",
                    AboutUsView()
                )
                
                Spacer()
                
                FooterView(text: "Version 1.0") // 프로젝트 identity의 version정보 가져오는 방법
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
        maxWidth: CGFloat = 150,
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

#Preview {
    HomeView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()),
        optionIntent: OptionIntent(optionStore: OptionStore())
    )
}
