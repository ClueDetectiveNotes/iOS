//
//  MarkerControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

import SwiftUI

struct MarkerControlBarView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    @ObservedObject private var optionStore: OptionStore
    @ObservedObject private var sheetStore: SheetStore
    @ObservedObject private var controlBarStore: ControlBarStore
    private let markerControlBarIntent: MarkerControlBarIntent
    
    @State private var newSubMarkerName: String = ""
    
    init(
        optionStore: OptionStore,
        sheetStore: SheetStore,
        controlBarStore: ControlBarStore
    ) {
        self.optionStore = optionStore
        self.sheetStore = sheetStore
        self.controlBarStore = controlBarStore
        self.markerControlBarIntent = MarkerControlBarIntent(
            optionStore: optionStore,
            sheetStore: sheetStore,
            controlBarStore: controlBarStore
        )
    }

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Spacer()
                
                // 창 닫기
                Button(
                    action: {
                        markerControlBarIntent.clickCloseButton()
                    },
                    label: {
                        Text("닫기")
                            .foregroundStyle(Color("blue1"))
                    }
                )
            }
            
            HStack {
                MainMarkerBtnsView(
                    markerControlBarIntent: markerControlBarIntent
                )
                
                Spacer()
            }
            
            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        SubMarkerBtnsView(
                            controlBarStore: controlBarStore,
                            markerControlBarIntent: markerControlBarIntent
                        )
                    }
                }
                .padding(.leading, 2)
                
                Spacer()
                
                Button(
                    action: {
                        markerControlBarIntent.clickPlusButton()
                    },
                    label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color("blue1"))
                    }
                )
                .frame(width: 40, height: 40)
            }
        }
        .frame(height: geometryStore.markerControlBarHeight)
        .padding(.horizontal)
        .background()
        .clipped()
        .shadow(radius: 4, x: 0, y: -7)
        .alert(
            "마커 추가",
            isPresented: $sheetStore.isDisplayAddSubMarkerAlert
        ) {
            TextField("마커 이름", text: $newSubMarkerName)
                .foregroundColor(Color.black)
            Button("확인") {
                markerControlBarIntent.addSubMarkerType(newSubMarkerName)
                newSubMarkerName = ""
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("추가할 마커의 이름을 입력해주세요.")
        }
        .alert(
            "O 입력시\n나머지 셀의 기존 메인마커가\n변경될 수 있습니다.\n\n계속 하시겠습니까?",
            isPresented: $sheetStore.isDisplayCheckMarkerAlert
        ) {
            Button("네") {
                markerControlBarIntent.clickYesButtonInCheckMarkerAlert()
            }
            Button("아니오", role: .cancel) { }
        } message: {
            Text("(서브마커 및 잠겨있는 셀의 마커는 변경되지 않음)")
        }
        // message는 View가 한줄밖에 들어가지 않음. 토글도 안들어감. custom한 alert이 필요할 듯
    }
}

struct MainMarkerBtnsView: View {
    @EnvironmentObject private var optionStore: OptionStore
    private let markerControlBarIntent: MarkerControlBarIntent
    private let mainMarkerTypes = MainMarker.markerType.allCases
    
    init(markerControlBarIntent: MarkerControlBarIntent) {
        self.markerControlBarIntent = markerControlBarIntent
    }

    var body: some View {
        ForEach(mainMarkerTypes, id: \.self) { mainMarkerType in
            Button(
                action: {
                    markerControlBarIntent.chooseMainMarker(
                        MainMarker(notation: mainMarkerType),
                        autoAnswerMode: optionStore.autoAnswerMode
                    )
                },
                label: {
                    Text(mainMarkerType.description)
                        .monospaced()
                        .foregroundStyle(Color("black1"))
                        .bold()
                }
            )
            .frame(width: 40, height: 40)
            .buttonStyle(.bordered)
        }
    }
}

struct SubMarkerBtnsView: View {
    @EnvironmentObject private var optionStore: OptionStore
    @ObservedObject private var controlBarStore: ControlBarStore
    private let markerControlBarIntent: MarkerControlBarIntent
    
    init(
        controlBarStore: ControlBarStore,
        markerControlBarIntent: MarkerControlBarIntent
    ) {
        self.controlBarStore = controlBarStore
        self.markerControlBarIntent = markerControlBarIntent
    }

    var body: some View {
        ForEach(optionStore.subMarkerTypes.filter({ $0.isUse == true }), id: \.self) { subMarkerType in
            Button(
                action: {
                    markerControlBarIntent.chooseSubMarker(SubMarker(notation: subMarkerType.notation))
                },
                label: {
                    Text(subMarkerType.notation)
                        .foregroundStyle(Color("darkgray1"))
                }
            )
            .frame(height: 40)
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    MarkerControlBarView(
        optionStore: OptionStore(),
        sheetStore: SheetStore(),
        controlBarStore: ControlBarStore()
    )
    .environmentObject(GeometryStore())
    .environmentObject(GameSettingStore())
}
