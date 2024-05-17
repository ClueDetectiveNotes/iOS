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
        VStack {
            HStack {
                MainMarkerBtnsView(markerControlBarInteractor: markerControlBarInteractor)
                
                Spacer()
                
                Button("취소") {
                    markerControlBarInteractor.excute(.clickCancelButton)
                }
            }
        }
        .onDisappear {
            markerControlBarInteractor.excute(.clickCancelButton)
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
            Button(mainMarkerType.description) {
                markerControlBarInteractor.excute(.chooseMainMarker(MainMarker(notation: mainMarkerType)))
            }
            .frame(width: 40, height: 40)
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    MarkerControlBarView(sheetStore: SheetStore())
}
