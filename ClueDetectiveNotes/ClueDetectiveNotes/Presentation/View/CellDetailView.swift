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
                RowContent(
                    title: "Player Name",
                    content: cell.colName.cardHolder.name
                )
                
                RowContent(
                    title: "Card Name",
                    content: cell.rowName.card.name
                )
                
                RowContent(
                    title: "Locked State",
                    content: (cell.isLock || cell.isInit) ? "잠금" : "잠금 해제"
                )
            } header: {
                Text("셀 정보")
            } footer: {
                if cell.isInit {
                    Text("설정시 초기화된 Cell입니다. 잠금을 해제할 수 없습니다.")
                }
            }
            
            Section {
                Text(cell.mainMarker?.notation.description ?? "비어 있음")
            } header: {
                Text("Main Marker")
            }
            
            Section {
                if !cell.subMarkers.isEmpty {
                    ForEach(cell.subMarkers, id: \.self) { subMarker in
                        Text(subMarker.notation)
                    }
                    .onDelete(perform: { indexSet in
                        sheetIntent.removeSubMarkerInCellDetailView(indexSet)
                    })
                } else {
                    Text("비어 있음")
                }
            } header: {
                Text("Sub Markers")
            } footer: {
                if !cell.subMarkers.isEmpty {
                    Text("스와이프 동작으로 삭제가 가능합니다.")
                }
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
