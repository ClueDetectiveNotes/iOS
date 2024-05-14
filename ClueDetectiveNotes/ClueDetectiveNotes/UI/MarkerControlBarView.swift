//
//  MarkerControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

import SwiftUI

struct MarkerControlBarView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let markerControlBarUseCase: MarkerControlBarUseCase
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
        self.markerControlBarUseCase = MarkerControlBarUseCase(sheetStore: sheetStore)
    }

    var body: some View {
        VStack {
            HStack {
                MainMarkerBtnsView(markerControlBarUseCase: markerControlBarUseCase)
                
                Spacer()
                
                Button("취소") {
                    markerControlBarUseCase.cancelClickedCell()
                }
            }
        }
        .onDisappear {
            markerControlBarUseCase.cancelClickedCell()
        }
    }
}

struct MainMarkerBtnsView: View {
    private let markerControlBarUseCase: MarkerControlBarUseCase
    private let mainMarkerTypes = MainMarker.markerType.allCases
    
    init(markerControlBarUseCase: MarkerControlBarUseCase) {
        self.markerControlBarUseCase = markerControlBarUseCase
    }

    var body: some View {
        ForEach(mainMarkerTypes, id: \.self) { mainMarkerType in
            Button(mainMarkerType.description) {
                markerControlBarUseCase.chooseMainMarker(marker: MainMarker(notation: mainMarkerType))
            }
            .frame(width: 40, height: 40)
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    MarkerControlBarView(sheetStore: SheetStore())
}
