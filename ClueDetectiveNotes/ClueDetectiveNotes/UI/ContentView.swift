//
//  ContentView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var sheetStore = SheetStore()
    let cardTypes = CardType.allCases
    
    var body: some View {
        ScrollView {
            ForEach(cardTypes, id: \.self) {
                cardType in
                VStack {
                    Text(cardType.description)
                    CardTypeSheetView(
                        sheetStore: sheetStore,
                        cardType: cardType
                    )
                }
            }
//            LazyVGrid(columns: columns) {
//                ForEach(sheetStore.sampleSheet.getRowNames(), id: \.self) { row in
//                    Text(row.card.name)
//                    ForEach(sheetStore.sampleSheet.getCells().filter { $0.getRowName() == row }, id: \.self) { cell in
//                        CellView(cell: cell, store: sheetStore)
//                            .background(sheetStore.sampleSheet.isSelectedCell(cell) ? Color.yellow : Color.blue)
//                    }
//                }
//            }
        }
    }
}

struct CardTypeSheetView: View {
    @ObservedObject var sheetStore: SheetStore
    private var cardType: CardType
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init(
        sheetStore: SheetStore,
        cardType: CardType
    ) {
        self.sheetStore = sheetStore
        self.cardType = cardType
    }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(sheetStore.sampleSheet.getRowNames(), id: \.self) { row in
                Text(row.card.name)
                ForEach(sheetStore.sampleSheet.getCells().filter { $0.getRowName() == row }, id: \.self) { cell in
                    CellView(
                        cell: cell,
                        store: sheetStore
                    )
                        .background(sheetStore.sampleSheet.isSelectedCell(cell) ? Color.yellow : Color.blue)
                }
            }
        }
    }
}

struct CellView: View {
    @State var cell: Cell
    private let clickCellUseCase: ClickCellUseCase
    
    init(
        cell: Cell,
        store: SheetStore
    ) {
        self.cell = cell
        self.clickCellUseCase = ClickCellUseCase(store: store)
    }
    
    var body: some View {
        Button(
            action: {
                do {
                    try clickCellUseCase.execute(cell: cell)
                } catch {
                    
                }
                //SheetViewModel.cellTapped(cell.rowName, cell.)
                // 클릭되었을 때 MarkerView 띄워짐
                // MarkerView() -> mainMarker, subMarkers
                // cell.setMainMarker(mainMarker)
                // cell.setSubMarkers(subMarkers)
                // 동기화
                //sheetViewModel.update(cell)
                //
                //test.cellTapped(cell)
            },
            label: {
                Text(cell.getColName().player.name)
                //Text(cell.getRowName().card.name)
                    .frame(width: 40, height: 40)
            }
        )
        .foregroundColor(.white)
    }
}

#Preview {
    ContentView()
}
