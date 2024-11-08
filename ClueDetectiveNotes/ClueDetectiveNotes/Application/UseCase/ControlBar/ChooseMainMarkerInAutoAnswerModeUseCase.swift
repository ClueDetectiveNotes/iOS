//
//  ChooseMainMarkerInAutoAnswerModeUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/30/24.
//

struct ChooseMainMarkerInAutoAnswerModeUseCase: UseCase {
    private var sheet: Sheet
    
    init(sheet: Sheet = GameSetter.shared.getSheet()) {
        self.sheet = sheet
    }
    
    func execute(_ marker: MainMarker) throws -> PresentationSheet {
        switch sheet.getMode() {
        case .single, .preInference:
            if let cell = sheet.getSelectedCells().first {
                if cell.equalsMainMarker(marker) {
                    cell.removeMainMarker()
                } else {
                    cell.setMainMarker(marker)
                }
            }
        case .multi:
            if sheet.isEveryCellMarkedWithMainMarker(),
               sheet.isSameMainMarkerInEveryCell(marker) {
                sheet.getSelectedCells().forEach { cell in
                    cell.removeMainMarker()
                }
            } else {
                sheet.getSelectedCells().forEach { cell in
                    cell.setMainMarker(marker)
                }
            }
        case .inference:
            let selectedCells = sheet.getSelectedCells()
            
            if sheet.isEveryCellMarkedWithMainMarker(),
               sheet.isSameMainMarkerInEveryCell(marker) {
                selectedCells.forEach { cell in
                    cell.removeMainMarker()
                }
            } else {
                selectedCells.forEach { cell in
                    cell.setMainMarker(marker)
                }
            }
            
            let currentColName = selectedCells[0].getColName()
            try selectNextInferenceCells(currentColName)
        }
        
        // 정답 자동 완성 작업
        AutocompleteAnswer()
        
        return createPresentationSheet()
    }
}

// MARK: - Private
extension ChooseMainMarkerInAutoAnswerModeUseCase {
    private func selectNextInferenceCells(_ currentColName: ColName) throws {
        // selectedCell, selectedColumnName 초기화
        sheet.unselectCell()
        sheet.unselectColumnName()
        
        // 다음 columnName 선택
        let nextColName = sheet.getNextColName(currentColName)
        _ = sheet.selectColumnName(nextColName)
        
        try sheet.switchModeInInferenceMode()
    }
    
    private func AutocompleteAnswer() {
        let selectedCells = sheet.getSelectedCells()
        var rowNames = Set<RowName>()
        
        selectedCells.forEach { cell in
            if !rowNames.contains(cell.getRowName()) {
                rowNames.insert(cell.getRowName())
            }
        }
        
        for rowName in rowNames {
            var cells = sheet.getRowCells(rowName)
            let answerIndex = cells.firstIndex(where: { !($0.getColName().cardHolder is Player) }) ?? 0
            let answer = cells[answerIndex]
            cells.remove(at: answerIndex)
            
            var isAllCrossMarker = true
            var countCheckMarker = 0
            var isAllMarker = true
            
            // row 내 cross, check 확인
            for cell in cells {
                isAllMarker = isAllMarker && !cell.isEmptyMainMarker()
                
                isAllCrossMarker = isAllCrossMarker && cell.equalsMainMarker(MainMarker(notation: .cross))
                
                if cell.equalsMainMarker(MainMarker(notation: .check)) {
                    countCheckMarker += 1
                }
            }
            
            if isAllCrossMarker {
                answer.setMainMarker(MainMarker(notation: .check))
            } else {
                if countCheckMarker > 0 {
                    if countCheckMarker != 1 {
                        // 토스트 메시지
                        print("Check 마크가 2개이상 입니다.")
                    }
                    
                    answer.setMainMarker(MainMarker(notation: .cross))
                    
                    // O, X, X, X(정답) 채워져있는 상태에서 정답에 i를 넣으면 O가 X되는 오류
                    // 자동 정답 모드에서는 정답에 입력 못하게 막아야하나
                    for cell in cells {
                        if cell.getMainMarker()?.notation != .check 
                            || (cell.getMainMarker()?.notation == .check
                                && !selectedCells.contains(cell)) {
                            cell.setMainMarker(MainMarker(notation: .cross))
                        }
                    }
                }
            }
        }
    }
    
    private func createPresentationSheet() -> PresentationSheet {
        return ConvertManager.getImmutableSheet(sheet)
    }
}
