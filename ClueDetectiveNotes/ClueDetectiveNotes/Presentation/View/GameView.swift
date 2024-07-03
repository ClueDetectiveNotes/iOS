//
//  GameView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/03/31.
//

import SwiftUI

struct GameView: View {
    @StateObject private var sheetStore = SheetStore()
    @ObservedObject private var settingStore: SettingStore
    private var settingInteractor: SettingInteractor
    
    @State private var newSubMarkerName: String = ""

    init(
        settingStore: SettingStore,
        settingInteractor: SettingInteractor
    ) {
        self.settingStore = settingStore
        self.settingInteractor = settingInteractor
    }
    
    var body: some View {
        VStack {
            SheetView(sheetStore: sheetStore)
                
            if sheetStore.isDisplayMarkerControlBar {
                MarkerControlBarView(
                    sheetStore: sheetStore,
                    settingStore: settingStore
                )
            }
            
            ControlBarView(sheetStore: sheetStore)
        }
        .alert(
            "마커 추가",
            isPresented: $sheetStore.isDisplayAddSubMarkerAlert
        ) {
            TextField("마커 이름", text: $newSubMarkerName)
            Button("확인") {
                settingInteractor.addSubMarker(SubMarker(notation: newSubMarkerName))
                newSubMarkerName = ""
            }
            Button("취소", role: .cancel) { }
        } message: {
            Text("추가할 마커의 이름을 입력해주세요.")
        }
    }
}

struct SheetView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetInteractor: SheetInteractor
    
    init(
        sheetStore: SheetStore
    ) {
        self.sheetStore = sheetStore
        self.sheetInteractor = SheetInteractor(sheetStore: sheetStore)
    }

    var body: some View {
        VStack {
            EmptyView()
                .frame(height: 1)
            
            PlayerRowView(
                sheetStore: sheetStore,
                sheetInteractor: sheetInteractor
            )
            
            ScrollView {
                VStack(spacing: 2) {
                    CardTypeView(
                        sheetStore: sheetStore,
                        sheetInterator: sheetInteractor,
                        cardType: .suspect
                    )
                    
                    CardTypeView(
                        sheetStore: sheetStore,
                        sheetInterator: sheetInteractor,
                        cardType: .weapon
                    )
                    
                    CardTypeView(
                        sheetStore: sheetStore,
                        sheetInterator: sheetInteractor,
                        cardType: .room
                    )
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.blue)
    }
}

private struct PlayerRowView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetInteractor: SheetInteractor
    
    let screenWidth = UIScreen.main.bounds.width
    
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
                    width: 90,
                    height: sheetStore.getCellSize(screenWidth).height
                )
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.colNames, id: \.self) { colName in
                    Button(
                        action: {
                            sheetInteractor.clickColName(colName)
                        },
                        label: {
                            Text(colName.player.name)
                                .foregroundStyle(.black)
                                .minimumScaleFactor(0.2)
                                .padding(7)
                        }
                    )
                    .frame(
                        width: sheetStore.getCellSize(screenWidth).width,
                        height: sheetStore.getCellSize(screenWidth).height
                    )
                    .background(colName.player is User ? Color.yellow : Color.white)
                }
            }
        }
    }
}

private struct CardTypeView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetInteractor: SheetInteractor
    private let cardType: CardType
    
    init(
        sheetStore: SheetStore,
        sheetInterator: SheetInteractor,
        cardType: CardType
    ) {
        self.sheetStore = sheetStore
        self.sheetInteractor = sheetInterator
        self.cardType = cardType
    }
    
    var body: some View {
        CardNameView(
            sheetStore: sheetStore,
            cardType: cardType
        )
        
        ForEach(sheetStore.sheet.rowNames.filter({ $0.card.type == cardType }), id: \.self) { rowName in
            CardRowView(
                sheetStore: sheetStore,
                sheetInteractor: sheetInteractor,
                rowName: rowName
            )
        }
    }
}

private struct CardNameView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let cardType: CardType
    
    let screenWidth = UIScreen.main.bounds.width
    
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
                    width: 90,
                    height: sheetStore.getCellSize(screenWidth).height
                )
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.colNames, id: \.self) { _ in
                    Rectangle()
                        .frame(
                            width: sheetStore.getCellSize(screenWidth).width,
                            height: sheetStore.getCellSize(screenWidth).height
                        )
                        .opacity(0)
                }
            }
        }
    }
}

private struct CardRowView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetInteractor: SheetInteractor
    private let rowName: RowName
    
    let screenWidth = UIScreen.main.bounds.width
    
    init(
        sheetStore: SheetStore,
        sheetInteractor: SheetInteractor,
        rowName: RowName
    ) {
        self.sheetStore = sheetStore
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
                }
            )
            .frame(
                width: 90,
                height: sheetStore.getCellSize(screenWidth).height
            )
            .background()
            
            HStack(spacing: 2) {
                ForEach(sheetStore.sheet.cells.filter({ $0.rowName == rowName }), id: \.self) { cell in
                    CellView(
                        sheetStore: sheetStore,
                        sheetInterator: sheetInteractor,
                        cell: cell
                    )
                }
            }
        }
    }
}

private struct CellView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetInteractor: SheetInteractor
    private var cell: PresentationCell
    
    let screenWidth = UIScreen.main.bounds.width
    
    init(
        sheetStore: SheetStore,
        sheetInterator: SheetInteractor,
        cell: PresentationCell
    ) {
        self.sheetStore = sheetStore
        self.sheetInteractor = sheetInterator
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
        .frame(
            width: sheetStore.getCellSize(screenWidth).width,
            height: sheetStore.getCellSize(screenWidth).height
        )
        
        .foregroundColor(.black)
        .border(
            sheetStore.sheet.isSelectedCell(cell) ?
            sheetStore.sheet.mode == .multi ? Color.orange : Color.green
            : Color.black,
            width: sheetStore.sheet.isSelectedCell(cell) ? 4 : 1
        )
        .background(
            sheetStore.sheet.isSelectedColName(cell.colName) || sheetStore.sheet.isSelectedRowName(cell.rowName) 
            ? Color(red: 204/255, green: 255/255, blue: 204/255, opacity: 0.7) 
            : Color.white
        )
        .simultaneousGesture(LongPressGesture().onEnded ({ _ in
                sheetInteractor.longClickCell(cell)
        }))
        .simultaneousGesture(TapGesture().onEnded({ _ in
            sheetInteractor.clickCell(cell)
        }))
        .highPriorityGesture(
            DragGesture().onChanged { _ in }
        )
    }
}

private struct EmptyView: View {
    var body: some View {
        Text("")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(
            settingStore: SettingStore(),
            settingInteractor: SettingInteractor(settingStore: SettingStore())
        )
    }
}
