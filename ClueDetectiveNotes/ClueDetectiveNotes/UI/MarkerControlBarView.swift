//
//  MarkerControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 5/11/24.
//

import SwiftUI

struct MarkerControlBarView: View {
    //@EnvironmentObject var appState: AppState
    private let mainMarkerTypes = MainMarker.markerType.allCases
    private let markerControlBarUseCase: MarkerControlBarUseCase
    
    init(markerControlBarUseCase: MarkerControlBarUseCase) {
        self.markerControlBarUseCase = markerControlBarUseCase
    }
    
    var body: some View {
        VStack {
            // Main Marker
            HStack {
                ForEach(mainMarkerTypes, id: \.self) { mainMarkerType in
                    Button(mainMarkerType.description) {
                        markerControlBarUseCase.chooseMainMarker(marker: MainMarker(notation: mainMarkerType))
                        print(mainMarkerType.description)
                    }
                    .frame(width: 40, height: 40)
                    .buttonStyle(.bordered)
                }
                
                Button("취소") {
                    markerControlBarUseCase.cancelClickedCell()
                }
            }
            
            // Sub Markers
            HStack {
                
            }
        }
        .onDisappear(perform: {
            markerControlBarUseCase.cancelClickedCell()
        })
    }
}


#Preview {
    MarkerControlBarView(markerControlBarUseCase: MarkerControlBarUseCase(state: AppState()))
}
