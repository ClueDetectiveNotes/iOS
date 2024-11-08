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
            List {
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

private struct LanguageSelectView: View {
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

private struct ScreenModeSelectView: View {
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

/*
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
*/
 
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
