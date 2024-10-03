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
    private let gameSettingInteractor: GameSettingInteractor
    private let geometryInteractor: GeometryInteractor
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    init(
        gameSettingInteractor: GameSettingInteractor,
        geometryInteractor: GeometryInteractor
    ) {
        self.gameSettingInteractor = gameSettingInteractor
        self.geometryInteractor = geometryInteractor
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SheetView(
                sheetStore: sheetStore,
                geometryInteractor: geometryInteractor
            )
            .overlay {
                sheetStore.isVisibleScreen ? Color.clear : Color.gray.opacity(0.99)
            }
                
            if sheetStore.isDisplayMarkerControlBar {
                MarkerControlBarView(
                    sheetStore: sheetStore,
                    controlBarStore: controlBarStore
                )
            }
            
            ControlBarView(sheetStore: sheetStore)
        }
        .overlay {
            GeometryReader { proxy in
                Color.clear // safeArea 포함한 크기
                    .onAppear {
                        geometryInteractor.setOriginSize(
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
    private let geometryInteractor: GeometryInteractor
    private let sheetInteractor: SheetInteractor
    
    init(
        sheetStore: SheetStore,
        geometryInteractor: GeometryInteractor
    ) {
        self.sheetStore = sheetStore
        self.geometryInteractor = geometryInteractor
        self.sheetInteractor = SheetInteractor(sheetStore: sheetStore)
    }
    
    var body: some View {
        VStack(spacing: 2) {
            EmptyView()
                .frame(height: 1)
            
            PlayerRowView(
                sheetStore: sheetStore,
                sheetInteractor: sheetInteractor
            )
            .clipped()
            
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 2) {
                        CardTypeView(
                            sheetStore: sheetStore, 
                            geometryInteractor: geometryInteractor,
                            sheetInterator: sheetInteractor,
                            cardType: .suspect
                        )
                        
                        CardTypeView(
                            sheetStore: sheetStore,
                            geometryInteractor: geometryInteractor,
                            sheetInterator: sheetInteractor,
                            cardType: .weapon
                        )
                        
                        CardTypeView(
                            sheetStore: sheetStore,
                            geometryInteractor: geometryInteractor,
                            sheetInterator: sheetInteractor,
                            cardType: .room
                        )
                    }
                }
                .onChange(of: geometryStore.selectedRowName) { rowName in
                    if geometryInteractor.isClickCoveredByControlBars() {
                        proxy.scrollTo(rowName)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .onAppear {
            sheetInteractor.initSheet()
        }
    }
}

private struct PlayerRowView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
    @ObservedObject private var sheetStore: SheetStore
    private let sheetInteractor: SheetInteractor
    
    init(
        sheetStore: SheetStore,
        sheetInteractor: SheetInteractor
    ) {
        self.sheetStore = sheetStore
        self.sheetInteractor = sheetInteractor
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
                            sheetInteractor.clickColName(colName)
                        },
                        label: {
                            Text(colName.cardHolder.name)
                                .foregroundStyle(.black)
                                .minimumScaleFactor(0.2)
                                .padding(7)
                                .underline(colName.cardHolder is User)
                        }
                    )
                    .frame(
                        width: geometryStore.getCellSize(sheetStore.sheet.colNames.count).width,
                        height: geometryStore.getCellSize(sheetStore.sheet.colNames.count).height
                    )
                    .background(Color.white)
                }
            }
        }
    }
}

private struct CardTypeView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let geometryInteractor: GeometryInteractor
    private let sheetInteractor: SheetInteractor
    
    private let cardType: CardType
    
    init(
        sheetStore: SheetStore,
        geometryInteractor: GeometryInteractor,
        sheetInterator: SheetInteractor,
        cardType: CardType
    ) {
        self.sheetStore = sheetStore
        self.geometryInteractor = geometryInteractor
        self.sheetInteractor = sheetInterator
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
                    geometryInteractor: geometryInteractor,
                    sheetInteractor: sheetInteractor,
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
    private let geometryInteractor: GeometryInteractor
    private let sheetInteractor: SheetInteractor
    
    private let rowName: RowName
    
    init(
        sheetStore: SheetStore,
        geometryInteractor: GeometryInteractor,
        sheetInteractor: SheetInteractor,
        rowName: RowName
    ) {
        self.sheetStore = sheetStore
        self.geometryInteractor = geometryInteractor
        self.sheetInteractor = sheetInteractor
        self.rowName = rowName
    }
    
    var body: some View {
        HStack {
            Button(
                action: {
                    sheetInteractor.clickRowName(rowName)
                },
                label: {
                    Text(rowName.card.name)
                        .padding(8)
                        .foregroundStyle(Color.black)
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
                ? Color.yellow
                : Color.white
            )
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.cells.filter({ $0.rowName == rowName }), id: \.self) { cell in
                    CellView(
                        sheetStore: sheetStore,
                        geometryInteractor: geometryInteractor,
                        sheetInteractor: sheetInteractor,
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
    private let geometryInteractor: GeometryInteractor
    private let sheetInteractor: SheetInteractor
    
    private var cell: PresentationCell
    
    init(
        sheetStore: SheetStore,
        geometryInteractor: GeometryInteractor,
        sheetInteractor: SheetInteractor,
        cell: PresentationCell
    ) {
        self.sheetStore = sheetStore
        self.geometryInteractor = geometryInteractor
        self.sheetInteractor = sheetInteractor
        self.cell = cell
    }
    
    var body: some View {
        VStack {
            Text(sheetStore.sheet.findCell(id: cell.id)?.mainMarker?.notation.description ?? "")
            
            HStack(spacing: 1) {
                if let cell = sheetStore.sheet.findCell(id: cell.id) {
                    ForEach(cell.subMarkers, id: \.self) { subMarker in
                        Text(subMarker.notation)
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
            sheetStore.sheet.isSelectedCell(cell) ?
            sheetStore.sheet.mode == .multi ? Color.orange : Color.green
            : Color.black,
            width: sheetStore.sheet.isSelectedCell(cell) ? 3 : 1
        )
        .background(
            GeometryReader { proxy in
                cellBackground
                    .simultaneousGesture(LongPressGesture().onEnded ({ _ in
                        print("long \(proxy.frame(in: .global).origin)")
                        let currentCoordinates = proxy.frame(in: .global).origin
                        
                        geometryInteractor.clickCell(
                            currentCoordinates: currentCoordinates,
                            currentRowName: cell.rowName
                        )
                        sheetInteractor.longClickCell(cell)
                    }))
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        print("tap \(proxy.frame(in: .global).origin)")
                        let currentCoordinates = proxy.frame(in: .global).origin
                        
                        geometryInteractor.clickCell(
                            currentCoordinates: currentCoordinates,
                            currentRowName: cell.rowName
                        )
                        sheetInteractor.clickCell(cell)
                    }))
            }
        )
        .highPriorityGesture(
            DragGesture().onChanged { _ in }
        )
    }
    
    var cellBackground: some View {
        sheetStore.sheet.isSelectedColName(cell.colName) || sheetStore.sheet.isSelectedRowName(cell.rowName)
        ? Color(red: 204/255, green: 255/255, blue: 204/255, opacity: 0.7)
        : Color.white
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(
            gameSettingInteractor: GameSettingInteractor(gameSettingStore: GameSettingStore()),
            geometryInteractor: GeometryInteractor(geometryStore: GeometryStore())
        )
        .environmentObject(GeometryStore(screenSize: .init(width: 375, height: 667)))
        .environmentObject(GameSettingStore())
    }
}
