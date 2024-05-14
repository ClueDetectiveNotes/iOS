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
                .background(Color.blue)
            
            if sheetStore.isDisplayMarkerControlBar {
                MarkerControlBarView(sheetStore: sheetStore)
                    .padding(.horizontal)
            }
        }
    }
}

struct SheetView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetUseCase: SheetUseCase
    
    init(
        sheetStore: SheetStore
    ) {
        self.sheetStore = sheetStore
        self.sheetUseCase = SheetUseCase(sheetStore: sheetStore)
    }

    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                
                Grid {
                    GridRow {
                        Text("")
                        ForEach(sheetStore.sheet.colNames, id: \.self) { colName in
                            Button(
                                action: {
                                    sheetUseCase.clickColName(colName)
                                },
                                label: {
                                    Text(colName.player.name)
                                        .padding(10)
                                        .background()
                                        .foregroundStyle(.black)
                                }
                            )
                        }
                    }
                    
                    CardTypeView(
                        sheetStore: sheetStore,
                        cardType: .suspect,
                        sheetUseCase: sheetUseCase
                    )
                    
                    CardTypeView(
                        sheetStore: sheetStore,
                        cardType: .weapon,
                        sheetUseCase: sheetUseCase
                    )
                    
                    CardTypeView(
                        sheetStore: sheetStore,
                        cardType: .room,
                        sheetUseCase: sheetUseCase
                    )
                }
                
                Spacer()
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
        cardType: CardType,
        sheetUseCase: SheetUseCase
    ) {
        self.sheetStore = sheetStore
        self.cardType = cardType
        self.sheetUseCase = sheetUseCase
    }
    
    var body: some View {
        GridRow {
            Text(cardType.description)
                .frame(height: 30)
                .gridCellColumns(1)
                .bold()
        }
        
        ForEach(sheetStore.sheet.rowNames.filter({ $0.card.type == cardType }), id: \.self) { rowName in
            GridRow {
                Button(
                    action: {
                        sheetUseCase.clickRowName(rowName)
                    },
                    label: {
                        Text(rowName.card.name)
                            .frame(width: 100)
                            .padding(10)
                            .background()
                            .foregroundStyle(Color.black)
                    }
                )
                
                ForEach(sheetStore.sheet.cells.filter({ $0.rowName == rowName }), id: \.self) { cell in
                    CellView(
                        sheetStore: sheetStore,
                        cell: cell,
                        sheetUseCase: sheetUseCase
                    )
                }
            }
        }
        
        Rectangle()
            .frame(height: 1)
    }
}

struct CellView: View {
    @ObservedObject private var sheetStore: SheetStore
    private var cell: PresentationCell
    private let sheetUseCase: SheetUseCase
    
    init(
        sheetStore: SheetStore,
        cell: PresentationCell,
        sheetUseCase: SheetUseCase
    ) {
        self.sheetStore = sheetStore
        self.cell = cell
        self.sheetUseCase = sheetUseCase
    }
    
    var body: some View {
        Button(
            action: { },
            label: {
                Text(sheetUseCase.loadCell(cell).mainMarker?.notation.description ?? "")
                    .frame(width: 40, height: 40)
            }
        )
        .foregroundColor(.black)
        .border(
            sheetStore.sheet.isSelectedCell(cell) ? Color.orange : Color.black,
            width: sheetStore.sheet.isSelectedCell(cell) ? 4 : 1
        )
        .background(
            sheetStore.sheet.isSelectedColName(cell.colName) || sheetStore.sheet.isSelectedRowName(cell.rowName) 
            ? Color(red: 204/255, green: 255/255, blue: 204/255, opacity: 0.7) 
            : Color.white
        )
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
        GameView()
    }
}
