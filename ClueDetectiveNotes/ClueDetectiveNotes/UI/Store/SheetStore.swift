//
//  SheetStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/9/24.
//

import Foundation

final class SheetStore: ObservableObject {
    @Published var selectedCells = [Cell]()
    @Published var isMultiMode: Bool = false
    @Published var sampleSheet: Sheet
    @Published var isDisplayMarkerControlBar = false
    
//    private var loadSheetUseCase = LoadSheetUseCase()
//    private var clickCellUseCase = ClickCellUseCase()
//    private var longClickCellUseCase = LongClickCellUseCase()
    
    init() {
        let state = try! LoadSheetUseCase().execute()
        let sheet = state["sheet"] as! Sheet
        selectedCells = sheet.getSelectedCells()
        isMultiMode = sheet.isMultiSelectionMode()
        self.sampleSheet = sheet
    }
    
//    func onLoadSheet() {
//        do {
//            let state = try loadSheetUseCase.execute()
//            let sheet = state["sheet"] as! Sheet
//            selectedCells = sheet.getSelectedCells()
//            isMultiMode = sheet.isMultiSelectionMode()
//            
//            sampleSheet = sheet
//        } catch {
////            return Sheet(players: [], cards: Edition.classic.cards)
//        }
//    }
//    
//    func onClickCell(_ cell: Cell) {
//        do {
//            let state = try clickCellUseCase.execute(cell: cell)
//            selectedCells = state["selectedCells"] as! [Cell]
//        } catch {
//            
//        }
//    }
//    
//    func onLongClickCell(_ cell: Cell) {
//        let state = longClickCellUseCase.execute(cell: cell)
//        selectedCells = state["selectedCells"] as! [Cell]
//        isMultiMode = state["isMultiSelectionMode"] as! Bool
//    }
}
