//
//  OptionView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/22/24.
//

import SwiftUI

enum Language: String, CaseIterable, Identifiable {
    case korean, english
    
    var id: Self { self }
    
    var text: String {
        switch self {
        case .korean:
            return "한국어"
        case .english:
            return "English"
        }
    }
}

enum ScreenMode: String, CaseIterable, Identifiable {
    case light, dark, system
    
    var id: Self { self }
    
    func getColorScheme() -> ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
}

struct OptionView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 44)
            
            TitleView(
                title: "옵션",
                description: ""
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                LanguagePickerView()
                
                Spacer()
                    .frame(height: 40)
                
                ScreenModePickerView()
                
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
    @State private var selectedLanguage: Language = .korean
    
    var body: some View {
        VStack(alignment: .leading) {
            SubTitleView("언어")
            
            Picker("Language", selection: $selectedLanguage) {
                ForEach(Language.allCases) { language in
                    Text(language.text)
                }
            }
        }
        .padding()
    }
}

private struct ScreenModePickerView: View {
    @AppStorage("screenMode") private var screenMode: ScreenMode = .system
    @StateObject private var colorSchemeObserver = ColorSchemeObserver()
    
    var body: some View {
        VStack(alignment: .leading) {
            SubTitleView("화면 모드")
            
            Picker("Screen Mode", selection: $screenMode) {
                ForEach(ScreenMode.allCases) { screenMode in
                    Text(screenMode.rawValue.capitalized) // 영어 첫문자 대문자로 만들어줌
                }
            }
        }
        .padding()
        .preferredColorScheme(
            screenMode == .system
            ? colorSchemeObserver.colorScheme
            : screenMode.getColorScheme()
        )
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
    OptionView()
}
