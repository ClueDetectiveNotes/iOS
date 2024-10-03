//
//  PublicCardsSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/15/24.
//

import SwiftUI

struct PublicCardsSettingView: View {
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
                    title: "공개 카드 설정",
                    description: "같은 장수가 되도록 나누고 남은 공개 카드를 설정해주세요."
                )
                
                SelectedCardsView(
                    gameSettingInteractor: gameSettingInteractor
                )
                
                Spacer()
                
                if gameSettingStore.isDisablePublicCardsSettingNextButton {
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
            //gameSettingInteractor.initGame()
            gameSettingInteractor.initPublicCards()
            //settingInteractor.initSelectedPublicCards()
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
            ForEach(gameSettingStore.gameGameSetting.selectedPublicCards, id: \.self) { card in
                VStack(spacing: 2) {
                    CardImage(name: card.type != .none ? card.rawName : "empty(white)")
                        .border(Color.black)
                        .onTapGesture {
                            gameSettingInteractor.selectPublicCard(card)
                            //settingInteractor.clickPublicCardInSelectedCardsView(card)
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
                                    //settingStore.selectedPublicCards.contains(card)
                                    ? Color.gray.opacity(0.7)
                                    : Color.clear
                                }
                                .onTapGesture {
                                    gameSettingInteractor.selectPublicCard(card)
                                    //settingInteractor.clickPublicCardInClueCardSetView(card)
                                }
                            
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
    private let gameSettingInteractor: GameSettingInteractor
    
    init(
        gameSettingInteractor: GameSettingInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
    }
    
    var body: some View {
        NavigationLink {
            MyCardsSettingView(
                gameSettingInteractor: gameSettingInteractor
            )
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
        .simultaneousGesture(TapGesture().onEnded({ _ in
            //settingInteractor.clickPublicCardsSettingNextButton()
        }))
    }
}

#Preview {
    PublicCardsSettingView(
        gameSettingInteractor: GameSettingInteractor(gameSettingStore: GameSettingStore())
    )
    .environmentObject(GameSettingStore())
}
