//
//  GameView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

struct GameView: View {
    @StateObject private var sheetStore = SheetStore()
    
    var body: some View {
        VStack {
            SheetView(sheetStore: sheetStore)
            
            if sheetStore.isDisplayMarkerControlBar {
                MarkerControlBarView(sheetStore: sheetStore)
            }
        }
        .padding(.horizontal)
    }
}

struct SheetView: View {
    @ObservedObject private var sheetStore: SheetStore
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
    }

    var body: some View {
        ScrollView {
            Grid {
                GridRow {
                    Text("-")
                    ForEach(sheetStore.sheet.colNames, id: \.self) { colName in
                        Text(colName.player.name)
                    }
                }
                
                CardTypeView(
                    sheetStore: sheetStore,
                    cardType: .suspect
                )
                
                CardTypeView(
                    sheetStore: sheetStore,
                    cardType: .weapon
                )
                
                CardTypeView(
                    sheetStore: sheetStore,
                    cardType: .room
                )
            }
        }
    }
}

struct CardTypeView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let cardType: CardType
    private let sheetUseCase: SheetUseCase
    
    init(
        sheetStore: SheetStore,
        cardType: CardType
    ) {
        self.sheetStore = sheetStore
        self.cardType = cardType
        self.sheetUseCase = SheetUseCase(sheetStore: sheetStore)
    }
    
    var body: some View {
        GridRow {
            Text(cardType.description)
                .frame(height: 30)
                .gridCellColumns(1)
        }
        
        ForEach(sheetStore.sheet.rowNames.filter({ $0.card.type == cardType }), id: \.self) { rowName in
            GridRow {
                Text(rowName.card.name)
                ForEach(sheetStore.sheet.cells.filter({ $0.rowName == rowName }), id: \.self) { cell in
                    CellView(cell: cell, sheetUseCase: sheetUseCase)
                        .background(sheetStore.sheet.isSelectedCell(cell) ? Color.yellow : Color.blue)

                }
            }
        }
    }
}

struct CellView: View {
    private var cell: PresentationCell
    private let sheetUseCase: SheetUseCase
    
    init(cell: PresentationCell, sheetUseCase: SheetUseCase) {
        self.cell = cell
        self.sheetUseCase = sheetUseCase
    }
    
    var body: some View {
        Button(
            action: { },
            label: {
                Text(cell.mainMarker?.notation.description ?? "")
                    .frame(width: 40, height: 40)
            }
        )
        .foregroundColor(.white)
        .simultaneousGesture(LongPressGesture().onEnded({ _ in
            sheetUseCase.longClickCell(cell)
            print(cell.mainMarker ?? "empty")
        }))
        .simultaneousGesture(TapGesture().onEnded({ _ in
            sheetUseCase.clickCell(cell)
            print(cell.mainMarker ?? "empty")
        }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
