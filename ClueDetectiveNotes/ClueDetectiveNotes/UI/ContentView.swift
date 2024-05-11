//
//  ContentView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appState: AppState = AppState()
    
    var body: some View {
        VStack {
            SheetView(sheetUseCase: SheetUseCase(state: appState))
                .environmentObject(appState)
            
            if appState.isActivityMarkerControlBar {
                MarkerControlBarView(markerControlBarUseCase: MarkerControlBarUseCase(state: appState))
                    .transition(.opacity)
            }
        }
        .padding(.horizontal)
    }
}

struct SheetView: View {
    @EnvironmentObject var appState: AppState
    private let sheetUseCase: SheetUseCase
//    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(sheetUseCase: SheetUseCase) {
        self.sheetUseCase = sheetUseCase
    }
    
    var body: some View {
        ScrollView {
            Grid {
                GridRow {
                    Text("-")
                    ForEach(appState.sheet.getColNames(), id: \.self) { colName in
                        Text(colName.player.name)
                    }
                }
                
                GridRow {
                    Text("용의자")
                        .frame(height: 30)
                        .gridCellColumns(1)
                }
                
                ForEach(appState.sheet.getRowNames().filter({ $0.card.type == .suspect }), id: \.self) { rowName in
                    GridRow {
                        Text(rowName.card.name)
                        ForEach(appState.sheet.getCells().filter({ $0.getRowName() == rowName })) { cell in
                            CellView(cell: cell, sheetUseCase: SheetUseCase(state: appState))
                        }
                    }
                }
                
                GridRow {
                    Text("무기")
                        .frame(height: 30)
                        .gridCellColumns(1)
                }
                
                ForEach(appState.sheet.getRowNames().filter({ $0.card.type == .weapon }), id: \.self) { rowName in
                    GridRow {
                        Text(rowName.card.name)
                        ForEach(appState.sheet.getCells().filter({ $0.getRowName() == rowName })) { cell in
                            CellView(cell: cell, sheetUseCase: SheetUseCase(state: appState))
                        }
                    }
                }
                
                GridRow {
                    Text("장소")
                        .frame(height: 30)
                        .gridCellColumns(1)
                }
                
                ForEach(appState.sheet.getRowNames().filter({ $0.card.type == .room }), id: \.self) { rowName in
                    GridRow {
                        Text(rowName.card.name)
                        ForEach(appState.sheet.getCells().filter({ $0.getRowName() == rowName })) { cell in
                            CellView(cell: cell, sheetUseCase: SheetUseCase(state: appState))
                        }
                    }
                }
            }
            //.frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }
}

struct CellView: View {
    @EnvironmentObject var appState: AppState
    @State var cell: Cell
    private let sheetUseCase: SheetUseCase
    
    init(
        cell: Cell,
        sheetUseCase: SheetUseCase
    ) {
        self.cell = cell
        self.sheetUseCase = sheetUseCase
    }
    
    var body: some View {
        Button(
            action: { },
            label: {
                Text(cell.getMainMarker()?.notation.description ?? "")
                    .frame(width: 40, height: 40)
            }
        )
        .foregroundColor(.white)
        .background(appState.sheet.isSelectedCell(cell) ? Color.yellow : Color.blue)
        .simultaneousGesture(LongPressGesture().onEnded({ _ in
            sheetUseCase.longClickCell(cell)
        }))
        .simultaneousGesture(TapGesture().onEnded({ _ in
            sheetUseCase.clickCell(cell)
        }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
