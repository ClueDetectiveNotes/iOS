//
//  ScreenModeSelectView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/19/24.
//

import SwiftUI

struct ScreenModeSelectView: View {
    @EnvironmentObject private var optionStore: OptionStore
    @StateObject private var colorSchemeObserver = ColorSchemeObserver()
    private let optionIntent: OptionIntent
    
    init(
        optionIntent: OptionIntent
    ) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                ForEach(ScreenMode.allCases) { screenMode in
                    HStack {
                        Button {
                            optionIntent.clickScreenMode(screenMode)
                        } label: {
                            HStack {
                                Text(screenMode.rawValue.capitalized)
                                    .foregroundStyle(Color("black1"))
                                
                                Spacer()
                                
                                if optionStore.screenMode == screenMode {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("스크린 모드")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(
            optionStore.screenMode == .system
            ? colorSchemeObserver.colorScheme
            : optionStore.screenMode.getColorScheme()
        )
    }
}
