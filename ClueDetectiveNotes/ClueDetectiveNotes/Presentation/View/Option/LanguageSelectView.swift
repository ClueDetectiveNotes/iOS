//
//  LanguageSelectView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/19/24.
//

import SwiftUI

struct LanguageSelectView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let optionIntent: OptionIntent
    
    init(
        optionIntent: OptionIntent
    ) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                ForEach(Language.allCases) { language in
                    HStack {
                        Button {
                            optionIntent.clickLanguage(language)
                        } label: {
                            HStack {
                                Text(language.text)
                                    .foregroundStyle(Color("black1"))
                                
                                Spacer()
                                
                                if optionStore.language == language {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("언어")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
