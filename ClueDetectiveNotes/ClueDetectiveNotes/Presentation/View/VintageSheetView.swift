//
//  VintageSheetView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2/2/25.
//

import SwiftUI

struct VintageSheetView: View {
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
            
            EmptyView()
                .frame(height: 20)
            
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
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
        .background(Color(red: 222/255, green: 224/255, blue: 216/255))
        
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
        HStack(spacing: 1) {
            EmptyView()
                .frame(
                    width: geometryStore.cardNameWidth,
                    height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                )
                .background(Color(red: 222/255, green: 224/255, blue: 216/255))
            
//            Spacer()
//                .frame(width: 1)
            
            HStack(spacing: 1) {
                ForEach(sheetStore.sheet.colNames.filter({ $0.cardHolder is Player}), id: \.self) { colName in
                    PlayerNameView(
                        sheetStore: sheetStore,
                        sheetIntent: sheetIntent,
                        colName: colName
                    )
                }
                
                if !sheetStore.isHiddenAnswer {
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
        VStack(spacing: 0) {
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
                Color(red: 222/255, green: 224/255, blue: 216/255)
                //            colName.cardHolder is Player
                //            ? Color("white1")
                //            : Color.indigo
            )
            
            Rectangle()
                .frame(
                    width: sheetStore.isHiddenAnswer
                    ? geometryStore.getCellSize(sheetStore.sheet.colNames.count - 1).width - 10
                    : geometryStore.getCellSize(sheetStore.sheet.colNames.count).width - 10,
                    height: 1
                )
                
        }
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
        VStack(spacing: 1) {
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
        .background(Color.black)
        .border(width: 1, edges: [.leading, .trailing], color: Color(red: 222/255, green: 224/255, blue: 216/255))
        .border(width: 1, edges: [.bottom], color: Color.black)
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
        HStack(spacing: 1) {
            HStack {
                Text(cardType.description)
                    .minimumScaleFactor(0.1)
                    .italic()
                    .bold()
                    .padding(8)
                    .padding(.leading, -6)
                    
                    
                Spacer()
            }
            .frame(
                width: geometryStore.cardNameWidth,
                height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
            )
            
//            Spacer()
//                .frame(width: 1)
            
            HStack(spacing: 1) {
                ForEach(sheetStore.sheet.colNames.filter({$0.cardHolder is Player}), id: \.self) { _ in
                    emptyRect
                }
            }
            
            if !sheetStore.isHiddenAnswer {
                emptyRect
            }
        }
        .background(Color(red: 222/255, green: 224/255, blue: 216/255))
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
        HStack(spacing: 1) {
            Button(
                action: {
                    sheetIntent.clickRowName(rowName)
                },
                label: {
                    HStack {
                        Text(rowName.card.name)
                            .padding(8)
                            .padding(.leading, 10)
                            .foregroundStyle(Color("black1"))
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                            //.underline(gameSettingStore.gameSetting.selectedMyCards.contains(rowName.card))
                        
                        Spacer()
                    }
                }
            )
            .frame(
                width: geometryStore.cardNameWidth,
                height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
            )
            .background(
                gameSettingStore.gameSetting.selectedPublicCards.contains(rowName.card)
                ? Color("yellow1")
                : Color(red: 222/255, green: 224/255, blue: 216/255)//Color("white1")
            )
            
//            Spacer()
//                .frame(width: 1)
            
            HStack(spacing: 1) {
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
                
                if !sheetStore.isHiddenAnswer {
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
            : Color.clear,
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
        ? Color("mint1")
        : cell.colName.cardHolder is Player ? Color(red: 222/255, green: 224/255, blue: 216/255) : Color("white1")
        //: cell.colName.cardHolder is Player ? Color("white1") : Color.gray
        
        //Color(red: 222/255, green: 224/255, blue: 216/255)
    }
}
