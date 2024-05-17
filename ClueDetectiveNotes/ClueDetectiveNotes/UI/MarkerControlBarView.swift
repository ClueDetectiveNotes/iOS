//
//  MarkerControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

import SwiftUI

struct MarkerControlBarView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let markerControlBarInteractor: MarkerControlBarInteractor
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
        self.markerControlBarInteractor = MarkerControlBarInteractor(sheetStore: sheetStore)
    }

    var body: some View {
        HStack {
            VStack {
                HStack {
                    MainMarkerBtnsView(markerControlBarInteractor: markerControlBarInteractor)
                    
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        SubMarkerBtnsView(markerControlBarInteractor: markerControlBarInteractor)
                        
                        Button(
                            action: {
                                
                            },
                            label: {
                                Image(systemName: "plus")
                            }
                        )
                    }
                    
                    Spacer()
                }
            }
            
            Divider()
            
            Button("취소") {
                markerControlBarInteractor.execute(.clickCancelButton)
            }
            .padding(6)
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .onDisappear {
            markerControlBarInteractor.execute(.clickCancelButton)
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
                    markerControlBarInteractor.execute(.chooseMainMarker(MainMarker(notation: mainMarkerType)))
                },
                label: {
                    Text(mainMarkerType.description)
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
    private let markerControlBarInteractor: MarkerControlBarInteractor
    private let subMarkerTypes = GameSetter.shared.getSubMarkerTypes()
    
    init(markerControlBarInteractor: MarkerControlBarInteractor) {
        self.markerControlBarInteractor = markerControlBarInteractor
    }

    var body: some View {
        ForEach(subMarkerTypes, id: \.self) { subMarkerType in
            Button(
                action: {
                    markerControlBarInteractor.execute(.chooseSubMarker(subMarkerType))
                },
                label: {
                    Text(subMarkerType.notation)
                        .foregroundStyle(Color(UIColor.darkGray))
                }
            )
            .frame(width: 40, height: 40)
            .buttonStyle(.bordered)
        }
    }
}



#Preview {
    MarkerControlBarView(sheetStore: SheetStore())
}
