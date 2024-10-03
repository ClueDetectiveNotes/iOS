//
//  MyCardsSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/18/24.
//

import SwiftUI

struct MyCardsSettingView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                TitleView(
                    title: "개인 카드 설정",
                    description: "개인 카드를 설정해주세요."
                )
                
                SelectedCardsView(
                    gameSettingInteractor: gameSettingInteractor
                )
                
                Spacer()
                
                if gameSettingStore.isDisableMyCardsSettingNextButton {
                    ClueCardSetView(
                        gameSettingInteractor: gameSettingInteractor
                    )
                } else {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    
                    NextButtonView(
                        gameSettingInteractor: gameSettingInteractor
                    )
                }
                
                Spacer()
            }
        }
        .onAppear {
            gameSettingInteractor.initMyCards()
        }
    }
}

private struct SelectedCardsView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        HStack() {
            ForEach(gameSettingStore.gameGameSetting.selectedMyCards, id: \.self) { card in
                VStack(spacing: 2) {
                    CardImage(name: card.type != .none ? card.rawName : "empty(white)")
                        .border(Color.black)
                        .onTapGesture {
                            gameSettingInteractor.selectMyCard(card)
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

private struct ClueCardSetView: View {
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack() {
                CardTypeHScrollView(
                    gameSettingInteractor: gameSettingInteractor,
                    cardType: .suspect
                )
                
                CardTypeHScrollView(
                    gameSettingInteractor: gameSettingInteractor,
                    cardType: .weapon
                )
                
                CardTypeHScrollView(
                    gameSettingInteractor: gameSettingInteractor,
                    cardType: .room
                )
            }
            .padding(.vertical)
        }
    }
}

private struct CardTypeHScrollView: View {
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    private let gameSettingInteractor: GameSettingInteractor
    let cardType: CardType

    init(
        gameSettingInteractor: GameSettingInteractor,
        cardType: CardType
    ) {
        self.gameSettingInteractor = gameSettingInteractor
        self.cardType = cardType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(cardType.description)
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
                                    ? Color.red.opacity(0.7)
                                    : gameSettingStore.gameGameSetting.selectedMyCards.contains(card)
                                    ? Color.gray.opacity(0.7)
                                    : Color.clear
                                }
                                .onTapGesture {
                                    print("뿅")
                                    gameSettingInteractor.selectMyCard(card)
                                }
                                .disabled(gameSettingStore.gameGameSetting.selectedPublicCards.contains(card))
                            
                            Text(card.name)
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
            .border(Color.gray)
    }
}

private struct NextButtonView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        NavigationLink {
            GameView(
                gameSettingInteractor: gameSettingInteractor,
                geometryInteractor: GeometryInteractor(geometryStore: geometryStore)
            )
            .navigationBarBackButtonHidden()
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    MyCardsSettingView(
        gameSettingInteractor: GameSettingInteractor(gameSettingStore: GameSettingStore())
    )
    .environmentObject(GeometryStore())
    .environmentObject(GameSettingStore())
}
