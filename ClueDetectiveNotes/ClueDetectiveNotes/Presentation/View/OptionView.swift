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

private struct SubMarkerListView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let optionIntent: OptionIntent
    
    init(optionIntent: OptionIntent) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    Section {
                        ForEach(optionStore.subMarkerTypes, id: \.self) { subMarkerType in
                            SubMarkerRow(
                                optionIntent: optionIntent,
                                subMarkerType: subMarkerType
                            )
                        }
                        .onMove { (source: IndexSet, destination: Int) in
                            optionIntent.reorderSubMarkerTypes(source: source, destination: destination)
                        }
                        .onDelete { indexSet in
                            optionIntent.deleteSubMarkerType(indexSet: indexSet)
                        }
                    }
                    
                    Section {
                        Button {
                            print("클릭")
                        } label: {
                            Text("초기화")
                                .frame(maxWidth: .infinity)
                        }
                    } footer: {
                        Text("서브 마커를 기본값으로 초기화 합니다.")
                    }

                }
                .toolbar {
                    EditButton()
                }
            }
            
            AddSubMarkerBtnView(optionIntent: optionIntent)
                .padding(.trailing, 30)
                .padding(.bottom, 30)
        }
    }
}

private struct SubMarkerRow: View {
    @EnvironmentObject private var optionStore: OptionStore
    @Environment(\.editMode) private var editMode
    private let optionIntent: OptionIntent
    private let subMarkerType: SubMarkerType
    
    @State private var isUsed: Bool
    
    init(
        optionIntent: OptionIntent,
        subMarkerType: SubMarkerType
    ) {
        self.optionIntent = optionIntent
        self.subMarkerType = subMarkerType
        self.isUsed = subMarkerType.isUse
    }
    
    var body: some View {
        HStack {
            Text("\(subMarkerType.notation)")
            
            Spacer()
            
            if editMode?.wrappedValue.isEditing == false {
                Toggle(isOn: $isUsed, label: {})
                    .labelsHidden()
                    .onChange(of: isUsed) { _ in
                        optionIntent.toggleSubMarkerType(subMarkerType)
                    }
            }
        }
    }
}

private struct AddSubMarkerBtnView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let optionIntent: OptionIntent
    
    @State private var newSubMarkerName: String = ""
    
    init(optionIntent: OptionIntent) {
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    optionIntent.clickPlusButton()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 45))
                }
            }
        }
        .alert(
            "마커 추가",
            isPresented: $optionStore.isDisplayAddSubMarkerAlert
        ) {
            TextField("마커 이름", text: $newSubMarkerName)
                .foregroundColor(Color.black)
            Button("확인") {
                optionIntent.addSubMarkerType(newSubMarkerName)
                newSubMarkerName = ""
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("추가할 마커의 이름을 입력해주세요.")
        }
    }
}

#Preview {
    OptionView(optionIntent: OptionIntent(optionStore: OptionStore()))
        .environmentObject(OptionStore())
}
