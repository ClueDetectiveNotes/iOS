//
//  MarkerControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

import SwiftUI

struct MarkerControlBarView: View {
    @ObservedObject private var sheetStore: SheetStore
    @ObservedObject private var settingStore: SettingStore
    private let markerControlBarInteractor: MarkerControlBarInteractor
    
    init(
        sheetStore: SheetStore,
        settingStore: SettingStore
    ) {
        self.sheetStore = sheetStore
        self.settingStore = settingStore
        self.markerControlBarInteractor = MarkerControlBarInteractor(sheetStore: sheetStore)
    }

    var body: some View {
        VStack {
            HStack {
                MainMarkerBtnsView(markerControlBarInteractor: markerControlBarInteractor)
                
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
                        settingStore: settingStore,
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
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
    @ObservedObject private var settingStore: SettingStore
    private let markerControlBarInteractor: MarkerControlBarInteractor
    
    init(
        settingStore: SettingStore,
        markerControlBarInteractor: MarkerControlBarInteractor
    ) {
        self.settingStore = settingStore
        self.markerControlBarInteractor = markerControlBarInteractor
    }

    var body: some View {
        ForEach(settingStore.setting.subMarkerTypes, id: \.self) { subMarkerType in
            Button(
                action: {
                    markerControlBarInteractor.chooseSubMarker(subMarkerType)
                },
                label: {
                    Text(subMarkerType.notation)
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
    MarkerControlBarView(sheetStore: SheetStore(), settingStore: SettingStore())
}
