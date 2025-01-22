//
//  CellDetailView2.swift
//  ClueDetectiveNotes
//
//  Created by MARY on 1/21/25.
//

import SwiftUI

struct CellDetailView2: View {
    @ObservedObject private var sheetStore: SheetStore
    private let sheetIntent: SheetIntent
    private var cell: PresentationCell
    @State private var isEditing: Bool = true
    
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
        VStack {
            HeaderView(cell: cell)
            Spacer()
                .frame(height: 20)
            
            HStack {
                Text("Main Marker")
                    .font(.title3)
                    .padding(.bottom, 16)
                Spacer()
            }
            HStack {
                if let mainMarker = cell.mainMarker {
                    MarkerView(isEditing: $isEditing, marker: mainMarker, onDelete: {
                        sheetIntent.removeMarkerInCellDetailView(mainMarker)
                    })
                } else {
                    Text("설정되어있는 마커가 없습니다.")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                Spacer()
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                Text("Sub Markers")
                    .font(.title3)
                    .padding(.bottom, 16)
                Spacer()
            }
            
            HStack {
                if !cell.subMarkers.isEmpty {
                    HStack {
                        ForEach(cell.subMarkers, id: \.self) { subMarker in
                            MarkerView(isEditing: $isEditing, marker: subMarker, onDelete: {
                                sheetIntent.removeMarkerInCellDetailView(subMarker)
                            })
                        }
                    }
                } else {
                    Text("설정되어있는 마커가 없습니다.")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

private struct HeaderView: View {
    private var cell: PresentationCell
    
    init(cell: PresentationCell) {
        self.cell = cell
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            InfoView(
                image: Image(systemName: "person.fill"),
                text: cell.colName.cardHolder.name
            )
            
            InfoView(
                image: Image(systemName: "questionmark.square.fill"),
                text: cell.rowName.card.name
            )
            
            InfoView(
                image: (cell.isLock || cell.isInit) ? Image(systemName: "lock.fill") : Image(systemName: "lock.open.fill"),
                text: (cell.isLock || cell.isInit) ? "잠금" : "잠금 해제"
            )
        }
        .padding(.vertical)
    }
}

private struct InfoView: View {
    private let image: Image
    private let text: String
    
    init(image: Image, text: String) {
        self.image = image
        self.text = text
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            image
                .resizable()
                .offset(y: 3)
                .frame(width: 20, height: 20, alignment: .center)
            Text(text)
                .font(.title2)
                .frame(alignment: .center)
        }
        .foregroundColor(.gray)
    }
}

struct MarkerView: View {
    @Binding var isEditing: Bool
    var marker: any Markable
    var onDelete: () -> Void
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(marker.description)
                .font(.headline)
                .padding(.vertical, 8) // 상하 여백 설정
                .padding(.horizontal, 16) // 좌우 여백 설정
                .background(Color(red: 224/255, green: 224/255, blue: 224/255).opacity(0.8)) // 반투명 배경색
                .cornerRadius(16) // 둥근 모서리
//                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5) // 그림자 효과
                .foregroundColor(.black) // 텍스트 색상
            
            // Delete Button
            if isEditing {
                Button(action: onDelete) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: -10, y: -10) // 조금 더 뷰 밖으로 이동
                }
                .buttonStyle(PlainButtonStyle()) // 버튼 스타일 제거
            }
        }
    }
}

#Preview {
    CellDetailView2(
        sheetStore: SheetStore.init(),
        sheetIntent: SheetIntent(sheetStore: SheetStore.init()),
        cell: PresentationCell.init(id: UUID(), rowName: RowName(card: Card(rawName: "", name: "촛대", type: .weapon)), colName: ColName(cardHolder: CardHolder(name: "mary")), mainMarker: MainMarker(notation: .question), subMarkers: [SubMarker(notation: "set1"), SubMarker(notation: "set22222")], isLock: false, isInit: false)
    )
}
