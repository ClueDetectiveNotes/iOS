//
//  SubMarkerListView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/19/24.
//

import SwiftUI

struct SubMarkerListView: View {
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
                            .moveDisabled(subMarkerType.isDefault)
                            .deleteDisabled(subMarkerType.isDefault)
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
                            optionIntent.clickSubMarkerInitButton()
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
        .navigationTitle("서브 마커 관리")
        .alert(
            "모든 서브 마커를 삭제할 수 없습니다.",
            isPresented: $optionStore.isShowingDeleteSubMarkerAlert
        ) {
            Button("확인", role: .cancel) { }
        }
        .alert(
            "초기화 하시겠습니까?",
            isPresented: $optionStore.isShowingInitSubMarkerAlert
        ) {
            Button("확인", role: .destructive) {
                optionIntent.initSubMarkerType()
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("게임 플레이 중 초기화는 게임 운영에 불편함을 줄 수 있습니다.")
        }
    }
}

/*
extension View {
    func editModeFix(_ editMode: Binding<EditMode>) -> some View {
        modifier(EditModeFixViewModifier(editMode: editMode))
    }
}

private struct EditModeFixView: View {
    @Environment(\.editMode) private var editModeEnvironment
    @Binding var editMode: EditMode
    
    var body: some View {
        Color.clear
            .onChange(of: editModeEnvironment?.wrappedValue) { editModeEnvironment in
                if let editModeEnvironment = editModeEnvironment {
                    editMode = editModeEnvironment
                }
            }
            .onChange(of: editMode) { value in
                editModeEnvironment?.wrappedValue = value
            }
    }
}

private struct EditModeFixViewModifier: ViewModifier {
    @Binding var editMode: EditMode
    
    func body(content: Content) -> some View {
        content
            .overlay {
                EditModeFixView(editMode: $editMode)
            }
    }
}
*/

private struct SubMarkerRow: View {
    @Environment(\.editMode) private var editMode
    @EnvironmentObject private var optionStore: OptionStore
    private let optionIntent: OptionIntent
    private let subMarkerType: SubMarkerType
    
    init(
        optionIntent: OptionIntent,
        subMarkerType: SubMarkerType
    ) {
        self.optionIntent = optionIntent
        self.subMarkerType = subMarkerType
    }
    
    var body: some View {
        HStack {
            Text("\(subMarkerType.notation)")
            
            Spacer()
            
            if editMode?.wrappedValue.isEditing == false {
                Toggle(isOn: .constant(subMarkerType.isUse), label: {})
                    .labelsHidden()
                    .onTapGesture {
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
            isPresented: $optionStore.isShowingAddSubMarkerAlert
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
    SubMarkerListView(optionIntent: OptionIntent(optionStore: OptionStore()))
        .environmentObject(OptionStore())
}
