//
//  GameView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

struct GameView: View {
    @StateObject private var sheetStore = SheetStore()
    @StateObject private var controlBarStore = ControlBarStore()
    @EnvironmentObject private var gameSettingStore: GameSettingStore
    @EnvironmentObject private var optionStore: OptionStore
    private let gameSettingIntent: GameSettingIntent
    private let geometryIntent: GeometryIntent
    private let optionIntent: OptionIntent
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(
        gameSettingIntent: GameSettingIntent,
        geometryIntent: GeometryIntent,
        optionIntent: OptionIntent
    ) {
        self.gameSettingIntent = gameSettingIntent
        self.geometryIntent = geometryIntent
        self.optionIntent = optionIntent
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SheetView(
                sheetStore: sheetStore,
                geometryIntent: geometryIntent
            )
            .overlay {
                sheetStore.isVisibleScreen 
                ? Color.clear
                : Color.gray.opacity(0.99)
            }
                
            if sheetStore.isDisplayMarkerControlBar {
                MarkerControlBarView(
                    sheetStore: sheetStore,
                    controlBarStore: controlBarStore
                )
            }
            
            ControlBarView(
                sheetStore: sheetStore,
                controlBarStore: controlBarStore,
                gameSettingIntent: gameSettingIntent,
                optionIntent: optionIntent
            )
        }
        .overlay {
            GeometryReader { proxy in
                Color.clear // safeArea 포함한 크기
                    .onAppear {
                        geometryIntent.setOriginSize(
                            screenSize: proxy.size,
                            safeAreaHeight: (safeAreaInsets.top, safeAreaInsets.bottom)
                        )
                    }
            }
        }
    }
}

struct SheetView: View {
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
        HStack {
            EmptyView()
                .frame(
                    width: geometryStore.cardNameWidth,
                    height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                )
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.colNames, id: \.self) { colName in
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
                        width: geometryStore.getCellSize(sheetStore.sheet.colNames.count).width,
                        height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                    )
                    .background(Color("white1"))
                }
            }
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
        HStack {
            Text(cardType.description)
                .minimumScaleFactor(0.1)
                .bold()
                .padding(8)
                .frame(
                    width: geometryStore.cardNameWidth,
                    height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                )
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.colNames, id: \.self) { _ in
                    Rectangle()
                        .frame(
                            width: geometryStore.getCellSize(sheetStore.sheet.colNames.count).width,
                            height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                        )
                        .opacity(0)
                }
            }
        }
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
        HStack {
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
                        .underline(gameSettingStore.gameGameSetting.selectedMyCards.contains(rowName.card))
                }
            )
            .frame(
                width: geometryStore.cardNameWidth,
                height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
            )
            .background(
                gameSettingStore.gameGameSetting.selectedPublicCards.contains(rowName.card)
                ? Color("yellow1")
                : Color("white1")
            )
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.cells.filter({ $0.rowName == rowName }), id: \.self) { cell in
                    CellView(
                        sheetStore: sheetStore,
                        geometryIntent: geometryIntent,
                        sheetIntent: sheetIntent,
                        cell: cell
                    )
                }
            }
        }
    }
}

private struct CellView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    private let geometryIntent: GeometryIntent
    private let sheetIntent: SheetIntent
    
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
            width: geometryStore.getCellSize(sheetStore.sheet.colNames.count).width,
            height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
        )
        .foregroundColor(.black)
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
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        print("tap \(proxy.frame(in: .global).origin)")
                        let currentCoordinates = proxy.frame(in: .global).origin
                        
                        geometryIntent.clickCell(
                            currentCoordinates: currentCoordinates,
                            currentRowName: cell.rowName
                        )
                        sheetIntent.clickCell(cell)
                    }))
            }
        )
        .highPriorityGesture(
            DragGesture().onChanged { _ in }
        )
        .overlay {
            if cell.isLock {
                lockInCell
            }
        }
    }
    
    private var lockInCell: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "lock.circle")
                    .foregroundStyle(Color("darkgray1"))
                    .frame(width:5)
                    .opacity(0.8)
                
                Spacer()
            }
            .padding(.leading, 5)
            
            Spacer()
        }
    }
    
    private var cellBackground: some View {
        sheetStore.sheet.isSelectedColName(cell.colName)
        || sheetStore.sheet.isSelectedRowName(cell.rowName)
        ? Color("mint1")
        : Color("white1")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(
            gameSettingIntent: GameSettingIntent(gameSettingStore: GameSettingStore()),
            geometryIntent: GeometryIntent(geometryStore: GeometryStore()), 
            optionIntent: OptionIntent(optionStore: OptionStore())
        )
        .environmentObject(GeometryStore(screenSize: .init(width: 375, height: 667)))
        .environmentObject(GameSettingStore())
    }
}
