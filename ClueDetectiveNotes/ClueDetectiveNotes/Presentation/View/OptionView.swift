//
//  OptionView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/22/24.
//

import SwiftUI

struct OptionView: View {
    private let optionIntent: OptionIntent
    
    init(
        optionIntent: OptionIntent
    ) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 44)
            
            TitleView(
                title: "옵션",
                description: ""
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                LanguagePickerView(
                    optionIntent: optionIntent
                )
                
                Spacer()
                    .frame(height: 40)
                
                ScreenModePickerView(
                    optionIntent: optionIntent
                )
                
                Spacer()
                    .frame(height: 40)
                
                AutoCompleteAnswerPickerView(
                    optionIntent: optionIntent
                )
                
                Spacer()
                    .frame(height: 40)
                
                DefaultSubMarkerView()
                
                Spacer()
            }
            .pickerStyle(.segmented)
        }
    }
}

private struct LanguagePickerView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let optionIntent: OptionIntent
    
    init(
        optionIntent: OptionIntent
    ) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SubTitleView("언어")
            
            Picker("Language", selection: $optionStore.language) {
                ForEach(Language.allCases) { language in
                    Text(language.text)
                }
            }
            .onChange(of: optionStore.language) { _ in
                optionIntent.saveOption()
            }
        }
        .padding()
    }
}

private struct ScreenModePickerView: View {
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
            SubTitleView("화면 모드")
            
            Picker("Screen Mode", selection: $optionStore.screenMode) {
                ForEach(ScreenMode.allCases) { screenMode in
                    Text(screenMode.rawValue.capitalized) // 영어 첫문자 대문자로 만들어줌
                }
            }
            .onChange(of: optionStore.screenMode) { _ in
                optionIntent.saveOption()
            }
        }
        .padding()
        .preferredColorScheme(
            optionStore.screenMode == .system
            ? colorSchemeObserver.colorScheme
            : optionStore.screenMode.getColorScheme()
        )
    }
}

private struct AutoCompleteAnswerPickerView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let optionIntent: OptionIntent
    
    init(
        optionIntent: OptionIntent
    ) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            SubTitleView("정답 자동 완성")
            
            Picker("Auto-Complete Answer", selection: $optionStore.autoAnswerMode) {
                ForEach(AutoAnswerMode.allCases) { mode in
                    Text(mode.text)
                }
            }
            .onChange(of: optionStore.autoAnswerMode) { _ in
                optionIntent.saveOption()
            }
        }
        .padding()
    }
}

private struct DefaultSubMarkerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            SubTitleView("서브마커 기본값 설정")
        }
        .padding()
    }
}

#Preview {
    OptionView(optionIntent: OptionIntent(optionStore: OptionStore()))
        .environmentObject(OptionStore())
}
