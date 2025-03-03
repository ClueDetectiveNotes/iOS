//
//  ClassicSheetView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2/2/25.
//

import SwiftUI

struct ClassicSheetView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    private let geometryIntent: GeometryIntent
    private let sheetIntent: SheetIntent
    
    init(
        sheetStore: SheetStore,
        geometryIntent: GeometryIntent
    ) {
        self.sheetStore = sheetStore
        self.geometryIntent = geometryIntent
        self.sheetIntent = SheetIntent(sheetStore: sheetStore)
    }
    
    var body: some View {
        VStack(spacing: 2) {
            EmptyView()
                .frame(height: 1)
            
            PlayerRowView(
                sheetStore: sheetStore,
                sheetIntent: sheetIntent
            )
            .clipped()
            
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 2) {
                        CardTypeView(
                            sheetStore: sheetStore,
                            geometryIntent: geometryIntent,
                            sheetIntent: sheetIntent,
                            cardType: .suspect
                        )
                        
                        CardTypeView(
                            sheetStore: sheetStore,
                            geometryIntent: geometryIntent,
                            sheetIntent: sheetIntent,
                            cardType: .weapon
                        )
                        
                        CardTypeView(
                            sheetStore: sheetStore,
                            geometryIntent: geometryIntent,
                            sheetIntent: sheetIntent,
                            cardType: .room
                        )
                    }
                }
                .onChange(of: geometryStore.selectedRowName) { rowName in
                    if geometryIntent.isClickCoveredByControlBars() {
                        proxy.scrollTo(rowName)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color("blue1"))
        //.background(Color(red: 97/255, green: 12/255, blue: 39/255))
        
        .onAppear {
            sheetIntent.initSheet()
        }
    }
}

private struct PlayerRowView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    private let sheetIntent: SheetIntent
    
    init(
        sheetStore: SheetStore,
        sheetIntent: SheetIntent
    ) {
        self.sheetStore = sheetStore
        self.sheetIntent = sheetIntent
    }
    
    var body: some View {
        HStack(spacing: 2) {
            EmptyView()
                .frame(
                    width: geometryStore.cardNameWidth,
                    height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                )
            
            Spacer()
                .frame(width: 1)
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.colNames.filter({ $0.cardHolder is Player}), id: \.self) { colName in
                    PlayerNameView(
                        sheetStore: sheetStore,
                        sheetIntent: sheetIntent,
                        colName: colName
                    )
                }
            }
            
            if !sheetStore.isHiddenAnswer {
                HStack(spacing: 2) {
                    PlayerNameView(
                        sheetStore: sheetStore,
                        sheetIntent: sheetIntent,
                        colName: sheetStore.sheet.colNames.filter({ !($0.cardHolder is Player)}).first!
                    )
                }
            }
        }
    }
}

private struct PlayerNameView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    private let sheetIntent: SheetIntent
    
    private let colName: ColName
    
    init(
        sheetStore: SheetStore,
        sheetIntent: SheetIntent,
        colName: ColName
    ) {
        self.sheetStore = sheetStore
        self.sheetIntent = sheetIntent
        self.colName = colName
    }
    
    var body: some View {
        Button(
            action: {
                sheetIntent.clickColName(colName)
            },
            label: {
                Text(colName.cardHolder.name)
                    .foregroundStyle(Color("black1"))
                    .minimumScaleFactor(0.2)
                    .padding(7)
                    .underline(colName.cardHolder is User)
            }
        )
        .frame(
            width: sheetStore.isHiddenAnswer
            ? geometryStore.getCellSize(sheetStore.sheet.colNames.count - 1).width
            : geometryStore.getCellSize(sheetStore.sheet.colNames.count).width,
            height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
        )
        .background(
            Color("white1")
//            colName.cardHolder is Player
//            ? Color("white1")
//            : Color.indigo
        )
    }
}

private struct CardTypeView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let geometryIntent: GeometryIntent
    private let sheetIntent: SheetIntent
    
    private let cardType: CardType
    
    init(
        sheetStore: SheetStore,
        geometryIntent: GeometryIntent,
        sheetIntent: SheetIntent,
        cardType: CardType
    ) {
        self.sheetStore = sheetStore
        self.geometryIntent = geometryIntent
        self.sheetIntent = sheetIntent
        self.cardType = cardType
    }
    
    var body: some View {
        VStack(spacing: 2) {
            CardNameView(
                sheetStore: sheetStore,
                cardType: cardType
            )
            
            ForEach(sheetStore.sheet.rowNames.filter({ $0.card.type == cardType }), id: \.self) { rowName in
                CardRowView(
                    sheetStore: sheetStore,
                    geometryIntent: geometryIntent,
                    sheetIntent: sheetIntent,
                    rowName: rowName
                )
            }
        }
    }
}

private struct CardNameView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    
    private let cardType: CardType
    
    init(
        sheetStore: SheetStore,
        cardType: CardType
    ) {
        self.sheetStore = sheetStore
        self.cardType = cardType
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Text(cardType.description)
                .minimumScaleFactor(0.1)
                .bold()
                .padding(8)
                .frame(
                    width: geometryStore.cardNameWidth,
                    height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                )
            
            Spacer()
                .frame(width: 1)
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.colNames.filter({$0.cardHolder is Player}), id: \.self) { _ in
                    emptyRect
                }
            }
            
            if !sheetStore.isHiddenAnswer {
                emptyRect
            }
        }
    }
    
    private var emptyRect: some View {
        Rectangle()
            .frame(
                width: sheetStore.isHiddenAnswer
                ? geometryStore.getCellSize(sheetStore.sheet.colNames.count - 1).width
                : geometryStore.getCellSize(sheetStore.sheet.colNames.count).width,
                height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
            )
            .opacity(0)
    }
}

private struct CardRowView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    @ObservedObject private var sheetStore: SheetStore
    private let geometryIntent: GeometryIntent
    private let sheetIntent: SheetIntent
    
    private let rowName: RowName
    
    init(
        sheetStore: SheetStore,
        geometryIntent: GeometryIntent,
        sheetIntent: SheetIntent,
        rowName: RowName
    ) {
        self.sheetStore = sheetStore
        self.geometryIntent = geometryIntent
        self.sheetIntent = sheetIntent
        self.rowName = rowName
    }
    
    var body: some View {
        HStack(spacing: 2) {
            Button(
                action: {
                    sheetIntent.clickRowName(rowName)
                },
                label: {
                    Text(rowName.card.name)
                        .padding(8)
                        .foregroundStyle(Color("black1"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .underline(gameSettingStore.gameSetting.selectedMyCards.contains(rowName.card))
                }
            )
            .frame(
                width: geometryStore.cardNameWidth,
                height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
            )
            .background(
                gameSettingStore.gameSetting.selectedPublicCards.contains(rowName.card)
                ? Color("yellow1")
                : Color("white1")
            )
            
            Spacer()
                .frame(width: 1)
            
            HStack(spacing: 2) {
                ForEach(
                    sheetStore.sheet.cells.filter({$0.rowName == rowName && !$0.isAnswer()}),
                    id: \.self
                ) { cell in
                    CellView(
                        sheetStore: sheetStore,
                        geometryIntent: geometryIntent,
                        sheetIntent: sheetIntent,
                        cell: cell
                    )
                }
            }
            
            if !sheetStore.isHiddenAnswer {
                HStack(spacing: 2) {
                    CellView(
                        sheetStore: sheetStore,
                        geometryIntent: geometryIntent,
                        sheetIntent: sheetIntent,
                        cell: sheetStore.sheet.cells.filter({ $0.rowName == rowName && $0.isAnswer()}).first!
                    )
                }
            }
        }
        .overlay {
            if sheetStore.sheet.isCrossInAnswer(rowName: rowName) {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color.red)
                    .offset(y: 2)
                    .padding(.horizontal, 5)
            }
        }
    }
}

private struct CellView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    private let geometryIntent: GeometryIntent
    private let sheetIntent: SheetIntent
    
    @State private var isDoubleTap: Bool = false
    private var cell: PresentationCell
    
    init(
        sheetStore: SheetStore,
        geometryIntent: GeometryIntent,
        sheetIntent: SheetIntent,
        cell: PresentationCell
    ) {
        self.sheetStore = sheetStore
        self.geometryIntent = geometryIntent
        self.sheetIntent = sheetIntent
        self.cell = cell
    }
    
    var body: some View {
        VStack {
            Text(sheetStore.sheet.findCell(id: cell.id)?.mainMarker?.notation.description ?? "")
                .foregroundStyle(Color("black1"))
            
            HStack(spacing: 1) {
                if let cell = sheetStore.sheet.findCell(id: cell.id) {
                    ForEach(cell.subMarkers, id: \.self) { subMarker in
                        Text(subMarker.notation)
                            .foregroundStyle(Color("black1"))
                            .font(.caption2)
                            .fontWeight(.light)
                    }
                }
            }
        }
        .id(cell.rowName)
        .frame(
            width: sheetStore.isHiddenAnswer
            ? geometryStore.getCellSize(sheetStore.sheet.colNames.count - 1).width
            : geometryStore.getCellSize(sheetStore.sheet.colNames.count).width,
            height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
        )
        .border(
            sheetStore.sheet.isSelectedCell(cell)
            ? sheetStore.sheet.mode == .multi ? Color("orange1") : Color("green1")
            : Color.black,
            width: sheetStore.sheet.isSelectedCell(cell) ? 3 : 1
        )
        .background(
            GeometryReader { proxy in
                cellBackground
                    .simultaneousGesture(LongPressGesture().onEnded ({ _ in
                        print("long \(proxy.frame(in: .global).origin)")
                        let currentCoordinates = proxy.frame(in: .global).origin
                        
                        geometryIntent.clickCell(
                            currentCoordinates: currentCoordinates,
                            currentRowName: cell.rowName
                        )
                        sheetIntent.longClickCell(cell)
                    }))
                    .simultaneousGesture(TapGesture(count:2).onEnded({ _ in
                        isDoubleTap = true
                        sheetIntent.doubleClickCell(cell)
                    }))
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                            if !isDoubleTap {
                                print("tap \(proxy.frame(in: .global).origin)")
                                let currentCoordinates = proxy.frame(in: .global).origin
                                
                                geometryIntent.clickCell(
                                    currentCoordinates: currentCoordinates,
                                    currentRowName: cell.rowName
                                )
                                sheetIntent.clickCell(cell)
                            }
                        }
                    }))
            }
        )
        .highPriorityGesture(
            DragGesture().onChanged { _ in }
        )
        .overlay {
            if !sheetStore.isHiddenLockImage && cell.isLock {
                lockInCell
            }
        }
        .sheet(isPresented: $isDoubleTap) {//$sheetStore.isShowingCellDetailView) {
            CellDetailView2(
                sheetStore: sheetStore,
                sheetIntent: sheetIntent,
                cell: cell
            )
            .presentationDetents([.fraction(0.5)])
        }
    }
    
    private var lockInCell: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "lock.circle")
                    .foregroundStyle(
                        cell.isInit ? Color("darkgray1") : Color("blue1")
                    )
                    .frame(width:4)
                    .opacity(0.6)
                
                Spacer()
            }
            .padding(.leading, 7)
            
            Spacer()
        }
    }
    
    private var cellBackground: some View {
        sheetStore.sheet.isSelectedColName(cell.colName)
        || sheetStore.sheet.isSelectedRowName(cell.rowName)
        ? Color("mint1") : Color("white1")
//        : cell.colName.cardHolder is Player ? Color("white1") : Color(red: 205/255, green: 92/255, blue: 8/255)
    }
}
