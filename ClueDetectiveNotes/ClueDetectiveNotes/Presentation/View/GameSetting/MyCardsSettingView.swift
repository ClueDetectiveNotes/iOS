//
//  MyCardsSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/18/24.
//

import SwiftUI

struct MyCardsSettingView: View {
    @EnvironmentObject private var optionStore: OptionStore
    @EnvironmentObject private var gameSettingStore: GameSettingStore
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
            VStack {
                TitleView(
                    title: optionStore.multiLang.getString(key: "HDS_TITLE"),//"개인 카드 설정",
                    description: optionStore.multiLang.getString(key: "HDS_DESC")//"개인 카드를 설정해주세요."
                )
                
                if gameSettingStore.gameSetting.myCardsCount == 6 {
                    GridSelectedCardsView(
                        gameSettingIntent: gameSettingIntent,
                        myCardCount: gameSettingStore.gameSetting.selectedMyCards.count
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
                        gameSettingIntent: gameSettingIntent, 
                        optionIntent: optionIntent
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
            ForEach(gameSettingStore.gameSetting.selectedMyCards, id: \.self) { card in
                SelectedCardView(
                    gameSettingIntent: gameSettingIntent,
                    card: card
                )
            }
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
    }
}

// 현재 사용하지 않음
private struct ScrollSelectedCardsView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    
    init(
        gameSettingIntent: GameSettingIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(gameSettingStore.gameSetting.selectedMyCards, id: \.self) { card in
                    SelectedCardView(
                        gameSettingIntent: gameSettingIntent,
                        card: card
                    )
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
    }
}

private struct GridSelectedCardsView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingIntent: GameSettingIntent
    private let myCardCount: Int
    private var maxCount: Int = 0
    
    init(
        gameSettingIntent: GameSettingIntent,
        myCardCount: Int
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.myCardCount = myCardCount
        self.maxCount = Int((Float(myCardCount) / 2.0).rounded())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(
                    gameSettingStore
                        .gameSetting
                        .selectedMyCards[0..<min(gameSettingStore.gameSetting.selectedMyCards.count, maxCount)],
                    id: \.self
                ) { card in
                    SelectedCardView(
                        gameSettingIntent: gameSettingIntent,
                        card: card
                    )
                }
            }
            .padding(.top, 25)
            
            HStack {
                ForEach(gameSettingStore.gameSetting.selectedMyCards[min(gameSettingStore.gameSetting.selectedMyCards.count, maxCount)...], id: \.self) { card in
                    SelectedCardView(
                        gameSettingIntent: gameSettingIntent,
                        card: card
                    )
                }
            }
            .padding(.bottom, 10)
        }
    }
}

private struct SelectedCardView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let gameSettingIntent: GameSettingIntent
    private let card: Card
    
    init(
        gameSettingIntent: GameSettingIntent,
        card: Card
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.card = card
    }
    
    var body: some View {
        VStack(spacing: 2) {
            CardImage(
                name: card.type != .none
                ? card.rawName
                : "empty(white)"
            )
            .border(Color("black1"))
            .onTapGesture {
                gameSettingIntent.selectMyCard(card)
            }
            
            Text(
                card.type != .none
                ? optionStore.multiLang.getString(key: card.name)
                : card.name
            )
                .foregroundStyle(Color("black1"))
                .frame(height: 20)
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
    @EnvironmentObject private var optionStore: OptionStore
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
            Text(optionStore.multiLang.getString(key: cardType.description))
                .bold()
                .foregroundStyle(Color("black1"))
                .padding(.vertical, 8)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(gameSettingStore.gameSetting.edition.deck.getCards(type: cardType), id: \.self) { card in
                        VStack(spacing: 2) {
                            CardImage(name: card.rawName)
                                .overlay {
                                    gameSettingStore.gameSetting.selectedPublicCards.contains(card)
                                    ? Color.red.opacity(0.7)
                                    : gameSettingStore.gameSetting.selectedMyCards.contains(card)
                                    ? Color.gray.opacity(0.7)
                                    : Color.clear
                                }
                                .onTapGesture {
                                    gameSettingIntent.selectMyCard(card)
                                }
                                .disabled(gameSettingStore.gameSetting.selectedPublicCards.contains(card))
                            
                            Text(optionStore.multiLang.getString(key: card.name))
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
    @EnvironmentObject private var optionStore: OptionStore
    @EnvironmentObject private var geometryStore: GeometryStore
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
        NavigationLink {
            GameView(
                gameSettingIntent: gameSettingIntent,
                geometryIntent: GeometryIntent(geometryStore: geometryStore), 
                optionIntent: optionIntent
            )
            .navigationBarBackButtonHidden()
        } label: {
            Text(optionStore.multiLang.getString(key: "NEXT"))//"다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
            .foregroundStyle(Color("button_white"))
        }
        .buttonStyle(.borderedProminent)
        .foregroundStyle(Color("blue1"))
        .padding(.bottom, 25)
    }
}

#Preview {
    MyCardsSettingView(
        gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()), 
        optionIntent: OptionIntent(optionStore: OptionStore())
    )
    .environmentObject(GeometryStore())
    .environmentObject(GameSettingStore())
}
