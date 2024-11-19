//
//  OptionView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/22/24.
//

import SwiftUI

struct OptionView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let optionIntent: OptionIntent
    
    init(
        optionIntent: OptionIntent
    ) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        //TitleView(title: "옵션", description: "")
        
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        LanguageSelectView(
                            optionIntent: optionIntent
                        )
                    } label: {
                        HStack {
                            Text("언어")
                            Spacer()
                            Text(optionStore.language.text)
                                .foregroundStyle(Color("subText"))
                        }
                    }
                    
                    NavigationLink {
                        ScreenModeSelectView(
                            optionIntent: optionIntent
                        )
                    } label: {
                        HStack {
                            Text("스크린 모드")
                            Spacer()
                            Text(optionStore.screenMode.rawValue.capitalized)
                                .foregroundStyle(Color("subText"))
                        }
                    }
                    
                    Toggle(
                        "정답 자동 완성",
                        isOn: $optionStore.autoAnswerMode
                    )
                    .onChange(of: optionStore.autoAnswerMode) { _ in
                        optionIntent.saveOption()
                    }
                    
                    NavigationLink {
                        SubMarkerListView(optionIntent: optionIntent)
                    } label: {
                        Text("서브 마커 관리")
                    }
                }
                
                Section {
                    NavigationLink {
                        //
                    } label: {
                        Text("도움말")
                    }
                }
                
                Section {
                    NavigationLink {
                        //
                    } label: {
                        Text("개발자")
                    }
                }
                
            }
        }
        .navigationTitle("옵션")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    OptionView(optionIntent: OptionIntent(optionStore: OptionStore()))
        .environmentObject(OptionStore())
}
