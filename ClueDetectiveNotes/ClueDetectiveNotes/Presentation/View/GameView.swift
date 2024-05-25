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
    @State private var newSubMarkerName: String = ""
    private var settingInteractor: SettingInteractor
    
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
                .background(Color.blue)
            
            if sheetStore.isDisplayMarkerControlBar {
                MarkerControlBarView(
                    sheetStore: sheetStore,
                    settingStore: settingStore
                )
                    .padding(.horizontal)
            }
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
        ScrollView {
            HStack {
                Spacer()
                
                Grid {
                    GridRow {
                        Text("")
                        
                        ForEach(sheetStore.sheet.colNames, id: \.self) { colName in
                            Button(
                                action: {
                                    sheetInteractor.clickColName(colName)
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
                        sheetInterator: sheetInteractor
                    )
                    
                    CardTypeView(
                        sheetStore: sheetStore,
                        cardType: .weapon,
                        sheetInterator: sheetInteractor
                    )
                    
                    CardTypeView(
                        sheetStore: sheetStore,
                        cardType: .room,
                        sheetInterator: sheetInteractor
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
    private let sheetInteractor: SheetInteractor
    
    init(
        sheetStore: SheetStore,
        cardType: CardType,
        sheetInterator: SheetInteractor
    ) {
        self.sheetStore = sheetStore
        self.cardType = cardType
        self.sheetInteractor = sheetInterator
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
                        sheetInteractor.clickRowName(rowName)
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
                        sheetInterator: sheetInteractor
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
    private let sheetInteractor: SheetInteractor
    
    init(
        sheetStore: SheetStore,
        cell: PresentationCell,
        sheetInterator: SheetInteractor
    ) {
        self.sheetStore = sheetStore
        self.cell = cell
        self.sheetInteractor = sheetInterator
    }
    
    var body: some View {
        Button(
            action: { 
                //
            },
            label: {
                VStack {
                    Text(sheetStore.sheet.findCell(id: cell.id)?.mainMarker?.notation.description ?? "")
                        
                    HStack {
                        if let cell = sheetStore.sheet.findCell(id: cell.id) {
                            ForEach(cell.subMarkers, id: \.self) { subMarker in
                                Text(subMarker.notation)
                                    .font(.caption)
                            }
                        }
                    }
                }
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
            sheetInteractor.longClickCell(cell)
        }))
        .simultaneousGesture(TapGesture().onEnded({ _ in
            sheetInteractor.clickCell(cell)
        }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(settingStore: SettingStore(), settingInteractor: SettingInteractor(settingStore: SettingStore()))
    }
}
