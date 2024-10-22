//
//  MyCardsSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/18/24.
//

import SwiftUI

struct MyCardsSettingView: View {
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
                    title: "개인 카드 설정",
                    description: "개인 카드를 설정해주세요."
                )
                
                if gameSettingStore.gameGameSetting.myCardsCount > 4 {
                    ScrollSelectedCardsView(
                        gameSettingIntenet: gameSettingIntent
                    )
                } else {
                    SelectedCardsView(
                        gameSettingIntent: gameSettingIntent
                    )
                }
                
                Spacer()
                
                if gameSettingStore.isDisableMyCardsSettingNextButton {
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
            gameSettingIntent.initMyCards()
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
            ForEach(gameSettingStore.gameGameSetting.selectedMyCards, id: \.self) { card in
                VStack(spacing: 2) {
                    CardImage(name: card.type != .none ? card.rawName : "empty(white)")
                        .border(Color.black)
                        .onTapGesture {
                            gameSettingIntent.selectMyCard(card)
                        }
                    
                    Text(card.name)
                        .frame(height: 20)
                }
            }
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
    }
}

private struct ScrollSelectedCardsView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntenet: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntenet
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(gameSettingStore.gameGameSetting.selectedMyCards, id: \.self) { card in
                    VStack(spacing: 2) {
                        CardImage(name: card.type != .none ? card.rawName : "empty(white)")
                            .border(Color("black1"))
                            .onTapGesture {
                                gameSettingIntent.selectMyCard(card)
                            }
                        
                        Text(card.name)
                            .foregroundStyle(Color("black1"))
                            .frame(height: 20)
                    }
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
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
                .bold()
                .foregroundStyle(Color("black1"))
                .padding(.vertical, 8)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(gameSettingStore.gameGameSetting.edition.deck.getCards(type: cardType), id: \.self) { card in
                        VStack(spacing: 2) {
                            CardImage(name: card.rawName)
                                .overlay {
                                    gameSettingStore.gameGameSetting.selectedPublicCards.contains(card)
                                    ? Color.red.opacity(0.7)
                                    : gameSettingStore.gameGameSetting.selectedMyCards.contains(card)
                                    ? Color.gray.opacity(0.7)
                                    : Color.clear
                                }
                                .onTapGesture {
                                    gameSettingIntent.selectMyCard(card)
                                }
                                .disabled(gameSettingStore.gameGameSetting.selectedPublicCards.contains(card))
                            
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
    @EnvironmentObject private var geometryStore: GeometryStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        NavigationLink {
            GameView(
                gameSettingIntent: gameSettingIntent,
                geometryIntent: GeometryIntent(geometryStore: geometryStore)
            )
            .navigationBarBackButtonHidden()
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
            .foregroundStyle(Color("button_white"))
        }
        .buttonStyle(.borderedProminent)
        .foregroundStyle(Color("blue1"))
    }
}

#Preview {
    MyCardsSettingView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore())
    )
    .environmentObject(GeometryStore())
    .environmentObject(GameSettingStore())
}
