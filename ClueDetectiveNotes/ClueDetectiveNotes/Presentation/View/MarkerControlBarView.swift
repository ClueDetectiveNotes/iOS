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
    @ObservedObject private var sheetStore: SheetStore
    @ObservedObject private var controlBarStore: ControlBarStore
    private let markerControlBarInteractor: MarkerControlBarInteractor
    
    @State private var newSubMarkerName: String = ""
    
    init(
        sheetStore: SheetStore,
        controlBarStore: ControlBarStore
    ) {
        self.sheetStore = sheetStore
        self.controlBarStore = controlBarStore
        self.markerControlBarInteractor = MarkerControlBarInteractor(
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
                        markerControlBarInteractor.clickCloseButton()
                    },
                    label: {
                        Text("닫기")
                            .foregroundStyle(Color("blue1"))
                    }
                )
            }
            
            HStack {
                MainMarkerBtnsView(
                    markerControlBarInteractor: markerControlBarInteractor
                )
                
                Spacer()
            }
            
            HStack {
                ScrollView(.horizontal) {
                    HStack {
                        SubMarkerBtnsView(
                            controlBarStore: controlBarStore,
                            markerControlBarInteractor: markerControlBarInteractor
                        )
                    }
                }
                .padding(.leading, 2)
                
                Spacer()
                
                Button(
                    action: {
                        markerControlBarInteractor.clickPlusButton()
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
            Button("확인") {
                markerControlBarInteractor.addSubMarker(SubMarker(notation: newSubMarkerName))
                newSubMarkerName = ""
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("추가할 마커의 이름을 입력해주세요.")
        }
    }
}

struct MainMarkerBtnsView: View {
    private let markerControlBarInteractor: MarkerControlBarInteractor
    private let mainMarkerTypes = MainMarker.markerType.allCases
    
    init(markerControlBarInteractor: MarkerControlBarInteractor) {
        self.markerControlBarInteractor = markerControlBarInteractor
    }

    var body: some View {
        ForEach(mainMarkerTypes, id: \.self) { mainMarkerType in
            Button(
                action: {
                    markerControlBarInteractor.chooseMainMarker(MainMarker(notation: mainMarkerType))
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
    @ObservedObject private var controlBarStore: ControlBarStore
    private let markerControlBarInteractor: MarkerControlBarInteractor
    
    init(
        controlBarStore: ControlBarStore,
        markerControlBarInteractor: MarkerControlBarInteractor
    ) {
        self.controlBarStore = controlBarStore
        self.markerControlBarInteractor = markerControlBarInteractor
    }

    var body: some View {
        ForEach(controlBarStore.controlBar.subMarkerTypes, id: \.self) { subMarkerType in
            Button(
                action: {
                    markerControlBarInteractor.chooseSubMarker(SubMarker(notation: subMarkerType))
                },
                label: {
                    Text(subMarkerType)
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
        sheetStore: SheetStore(), 
        controlBarStore: ControlBarStore()
    )
    .environmentObject(GeometryStore())
    .environmentObject(GameSettingStore())
}
