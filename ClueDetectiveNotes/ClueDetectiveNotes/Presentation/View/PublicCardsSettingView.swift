//
//  PublicCardsSettingView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/15/24.
//

import SwiftUI

struct PublicCardsSettingView: View {
    @ObservedObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                TitleView(
                    title: "카드 설정",
                    description: "같은 장수가 되도록 나누고 남은 공개 카드를 설정해주세요."
                )
                
                if settingInteractor.isExistPublicCard() {
                    ChosenCardsView(settingStore: settingStore, settingInteractor: settingInteractor)
                    
                    
                    //아직 선택해야할 카드가 남아있다면
                    if !settingInteractor.isCardSelectionComplete() {
                        Spacer()
                        
                        ChooseCardView(
                            settingStore: settingStore,
                            settingInteractor: settingInteractor
                        )
                    }
                } else { // 공개카드가 없거나
                    Text("남은 공개 카드가 없습니다.")
                    Text("다음 버튼을 눌러주세요.")
                }
                
                // 카드가 모두 선택되었다면 버튼 보임
                if settingInteractor.isCardSelectionComplete() {
                    Spacer()
                    
                    NextButtonView(
                        settingStore: settingStore,
                        settingInteractor: settingInteractor
                    )
                }
            }
            .onAppear {
                settingInteractor.initSelectedPublicCards()
            }
        }
    }
}

private struct ChosenCardsView: View {
    @ObservedObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        HStack() {
            ForEach(settingStore.selectedPublicCards, id: \.self) { card in
                VStack(spacing: 2) {
                    CardImage(name: card.type != .none ? card.rawName : "empty(white)")
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            settingInteractor.clickCard2(card: card)
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

private struct ChooseCardView: View {
    @ObservedObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack() {
                CardTypeHScrollView(
                    settingStore: settingStore,
                    settingInteractor: settingInteractor,
                    cardType: .suspect
                )
                
                CardTypeHScrollView(
                    settingStore: settingStore,
                    settingInteractor: settingInteractor,
                    cardType: .weapon
                )
                
                CardTypeHScrollView(
                    settingStore: settingStore,
                    settingInteractor: settingInteractor,
                    cardType: .room
                )
            }
            .padding(.vertical)
        }
    }
}

private struct CardTypeHScrollView: View {
    @ObservedObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    let cardType: CardType

    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor,
        cardType: CardType
    ) {
        self.settingStore = settingStore
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
                                    settingStore.selectedPublicCards.contains(card) ? Color.gray.opacity(0.7) : Color.clear
                                        
                                }
                                .onTapGesture {
                                    settingInteractor.clickCard(card: card)
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
    @ObservedObject private var settingStore: SettingStore
    private let settingInteractor: SettingInteractor
    
    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        NavigationLink {
            MyCardsSettingView()
        } label: {
            Text("다음")
            .frame(maxWidth: 250)
            .frame(height: 40)
        }
        .navigationDestination(for: String.self) { _ in
            MyCardsSettingView()
        }
        .buttonStyle(.borderedProminent)
        .simultaneousGesture(TapGesture().onEnded({ _ in
            settingInteractor.clickPublicCardsSettingNextButton()
        }))
    }
}

#Preview {
    PublicCardsSettingView(
        settingStore: SettingStore(),
        settingInteractor: SettingInteractor(settingStore: SettingStore())
    )
}
