//
//  CellDetailView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 12/17/24.
//

import SwiftUI

struct CellDetailView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetIntent: SheetIntent
    private var cell: PresentationCell
    
    init(
        sheetStore: SheetStore,
        sheetIntent: SheetIntent,
        cell: PresentationCell
    ) {
        self.sheetStore = sheetStore
        self.sheetIntent = sheetIntent
        self.cell = cell
    }
    
    var body: some View {
        List {
            Section {
                Text(cell.mainMarker?.notation.description ?? "비어있음")
            } header: {
                Text("Main Marker")
            }
            
            Section {
                ForEach(cell.subMarkers, id: \.self) { subMarker in
                    Text(subMarker.notation)
                }
                .onDelete(perform: { indexSet in
                    sheetIntent.removeSubMarkerInCellDetailView(indexSet)
                })
            } header: {
                Text("Sub Markers")
            } footer: {
                Text("서브 마커 삭제가 가능합니다.")
            }
            
            Section {
                RowContent(
                    title: "Player Name",
                    content: cell.colName.cardHolder.name
                )
                
                RowContent(
                    title: "Card Name",
                    content: cell.rowName.card.name
                )
                
                RowContent(
                    title: "Lock",
                    content: cell.isLock ? "잠겨있음" : "잠겨있지 않음"
                )
                
                RowContent(
                    title: cell.isInit ? "처음 설정시 초기화된 cell로 Main Marker 변경 불가" : "잠겨 있지 않으면 Main Marker 변경 가능",
                    content: ""
                )
            }
        }
    }
}

private struct RowContent: View {
    private let title: String
    private let content: String
    
    init(
        title: String,
        content: String
    ) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(content)
                .foregroundStyle(Color("subText"))
        }
    }
}

#Preview {
    CellDetailView(
        sheetStore: SheetStore(),
        sheetIntent: SheetIntent(sheetStore: SheetStore()),
        cell: PresentationCell(
            id: UUID(),
            rowName: RowName(card: Edition.classic.deck.suspects.first!),
            colName: ColName(cardHolder: CardHolder(name: "영수")),
            mainMarker: MainMarker(notation: .question),
            subMarkers: [
                SubMarker(notation: "1"),
                SubMarker(notation: "2"),
                SubMarker(notation: "3"),
                SubMarker(notation: "4")
            ],
            isLock: false,
            isInit: true
        )
    )
}
