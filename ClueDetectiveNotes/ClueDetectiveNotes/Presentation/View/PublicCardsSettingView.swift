//
//  PublicCardsSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/15/24.
//

import SwiftUI

struct PublicCardsSettingView: View {
    @EnvironmentObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                TitleView(
                    title: "공개 카드 설정",
                    description: "같은 장수가 되도록 나누고 남은 공개 카드를 설정해주세요."
                )
                
                SelectedCardsView(
                    settingInteractor: settingInteractor
                )
                
                Spacer()
                
                if !settingInteractor.isPublicCardSelectionComplete() {
                    ClueCardSetView(
                        settingInteractor: settingInteractor
                    )
                } else {
                    Spacer()
                        .frame(maxHeight: .infinity)
                    
                    NextButtonView(
                        settingInteractor: settingInteractor
                    )
                }
                
                Spacer()
            }
        }
        .onAppear {
            settingInteractor.initSelectedPublicCards()
        }
    }
}

private struct SelectedCardsView: View {
    @EnvironmentObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        HStack() {
            ForEach(settingStore.selectedPublicCards, id: \.self) { card in
                VStack(spacing: 2) {
                    CardImage(name: card.type != .none ? card.rawName : "empty(white)")
                        .border(Color.black)
                        .onTapGesture {
                            settingInteractor.clickPublicCardInSelectedCardsView(card)
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
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack() {
                CardTypeHScrollView(
                    settingInteractor: settingInteractor,
                    cardType: .suspect
                )
                
                CardTypeHScrollView(
                    settingInteractor: settingInteractor,
                    cardType: .weapon
                )
                
                CardTypeHScrollView(
                    settingInteractor: settingInteractor,
                    cardType: .room
                )
            }
            .padding(.vertical)
        }
    }
}

private struct CardTypeHScrollView: View {
    @EnvironmentObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    let cardType: CardType

    init(
        settingInteractor: SettingInteractor,
        cardType: CardType
    ) {
        self.settingInteractor = settingInteractor
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
                    ForEach(settingStore.setting.edition.cards.getCards(type: cardType), id: \.self) { card in
                        VStack(spacing: 2) {
                            CardImage(name: card.rawName)
                                .overlay {
                                    settingStore.selectedPublicCards.contains(card) 
                                    ? Color.gray.opacity(0.7)
                                    : Color.clear
                                }
                                .onTapGesture {
                                    settingInteractor.clickPublicCardInClueCardSetView(card)
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
    private let settingInteractor: SettingInteractor
    
    init(
        settingInteractor: SettingInteractor
    ) {
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        NavigationLink {
            MyCardsSettingView(
                settingInteractor: settingInteractor
            )
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
        .simultaneousGesture(TapGesture().onEnded({ _ in
            settingInteractor.clickPublicCardsSettingNextButton()
        }))
    }
}

#Preview {
    PublicCardsSettingView(
        settingInteractor: SettingInteractor(settingStore: SettingStore())
    )
    .environmentObject(SettingStore())
}
