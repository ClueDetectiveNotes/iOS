//
//  PublicCardsSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/15/24.
//

import SwiftUI

struct PublicCardsSettingView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TitleView(
                    title: "공개 카드 설정",
                    description: "같은 장수가 되도록 나누고 남은 공개 카드를 설정해주세요."
                )
                
                SelectedCardsView(
                    gameSettingIntent: gameSettingIntent
                )
                
                Spacer()
                
                if gameSettingStore.isDisablePublicCardsSettingNextButton {
                    ClueCardSetView(
                        gameSettingIntent: gameSettingIntent
                    )
                } else {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    
                    NextButtonView(
                        gameSettingIntent: gameSettingIntent
                    )
                }
                
                Spacer()
            }
        }
        .onAppear {
            gameSettingIntent.initPublicCards()
        }
    }
}

private struct SelectedCardsView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        HStack {
            ForEach(gameSettingStore.gameGameSetting.selectedPublicCards, id: \.self) { card in
                VStack(spacing: 2) {
                    CardImage(
                        name: card.type != .none
                        ? card.rawName
                        : "empty(white)"
                    )
                    .border(Color("black1"))
                    .onTapGesture {
                        gameSettingIntent.selectPublicCard(card)
                    }
                    
                    Text(card.name)
                        .foregroundStyle(Color("black1"))
                        .frame(height: 20)
                }
            }
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
    }
}

private struct ClueCardSetView: View {
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardTypeHScrollView(
                    gameSettingIntent: gameSettingIntent,
                    cardType: .suspect
                )
                
                CardTypeHScrollView(
                    gameSettingIntent: gameSettingIntent,
                    cardType: .weapon
                )
                
                CardTypeHScrollView(
                    gameSettingIntent: gameSettingIntent,
                    cardType: .room
                )
            }
            .padding(.vertical)
        }
    }
}

private struct CardTypeHScrollView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    let cardType: CardType

    init(
        gameSettingIntent: GameSettingIntent,
        cardType: CardType
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.cardType = cardType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(cardType.description)
                .foregroundStyle(Color("black1"))
                .bold()
                .padding(.vertical, 8)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(gameSettingStore.gameGameSetting.edition.deck.getCards(type: cardType), id: \.self) { card in
                        VStack(spacing: 2) {
                            CardImage(name: card.rawName)
                                .overlay {
                                    gameSettingStore.gameGameSetting.selectedPublicCards.contains(card)
                                    ? Color.gray.opacity(0.7)
                                    : Color.clear
                                }
                                .onTapGesture {
                                    gameSettingIntent.selectPublicCard(card)
                                }
                            
                            Text(card.name)
                                .foregroundStyle(Color("black1"))
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

private struct CardImage: View {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        Image(name)
            .resizable()
            .frame(width: 70, height: 70)
            .border(Color("border_gray"))
    }
}

private struct NextButtonView: View {
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        NavigationLink {
            MyCardsSettingView(
                gameSettingIntent: gameSettingIntent
            )
        } label: {
            Text("다음")
                .foregroundStyle(Color("button_white"))
                .frame(maxWidth: 250)
                .frame(height: 40)
        }
        .foregroundStyle(Color("blue1"))
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    PublicCardsSettingView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore())
    )
    .environmentObject(GameSettingStore())
}
