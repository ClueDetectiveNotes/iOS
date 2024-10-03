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
        VStack {
            Spacer()
            
            HStack {
                MainMarkerBtnsView(
                    markerControlBarInteractor: markerControlBarInteractor
                )
                
                Spacer()
                
                // 창 닫기
                Button(
                    action: {
                        markerControlBarInteractor.clickCloseButton()
                    },
                    label: {
                        Image(systemName: "xmark.circle")
                            .foregroundStyle(.red)
                    }
                )
            }
            
            ScrollView(.horizontal) {
                HStack {
                    SubMarkerBtnsView(
                        controlBarStore: controlBarStore,
                        markerControlBarInteractor: markerControlBarInteractor
                    )
                    
                    Button(
                        action: {
                            markerControlBarInteractor.clickPlusButton()
                        },
                        label: {
                            Image(systemName: "plus")
                        }
                    )
                    .frame(width: 40, height: 40)
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .frame(height: geometryStore.markerControlBarHeight)
        .padding(.horizontal)
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
                        .foregroundStyle(Color.black)
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
                        .monospaced()
                        .foregroundStyle(Color(UIColor.darkGray))
                }
            )
            .frame(width: 40, height: 40)
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
