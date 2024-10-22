//
//  OptionView.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/22/24.
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
    case light, dark
    
    var id: Self { self }
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
    @State private var selectedScreenMode: ScreenMode = .light
    
    var body: some View {
        VStack(alignment: .leading) {
            SubTitleView("화면 모드")
            
            Picker("Screen Mode", selection: $selectedScreenMode) {
                ForEach(ScreenMode.allCases) { screenMode in
                    Text(screenMode.rawValue)
                }
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

private struct SubTitleView: View {
    private let subTitle: String
    
    init(_ subTitle: String) {
        self.subTitle = subTitle
    }
    
    var body: some View {
        HStack {
            Text(subTitle)
                .font(.title3)
            
            Spacer()
        }
    }
}

#Preview {
    OptionView()
}
