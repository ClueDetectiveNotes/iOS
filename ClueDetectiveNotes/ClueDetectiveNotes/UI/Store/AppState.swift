//
//  AppState.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 5/10/24.
//

import Foundation

final class AppState: ObservableObject {
    @Published var sheet: Sheet
    @Published var isActivityMarkerControlBar: Bool
    
    init(
        sheet: Sheet  = GameSetter.shared.getSheetInstance(),
        isActivityMarkerControlBar: Bool = false
    ) {
        self.sheet = sheet
        self.isActivityMarkerControlBar = isActivityMarkerControlBar
    }
}

struct SheetUseCase {
    private var state: AppState
    
    init(state: AppState) {
        self.state = state
    }
    
    func longClickCell(_ cell: Cell) {
        if !state.sheet.isMultiSelectionMode() {
            state.sheet.switchSelectionMode()
        }
        
        if state.sheet.isSelectedCell(cell) {
            state.isActivityMarkerControlBar = false
        } else {
            state.isActivityMarkerControlBar = true
        }
        
        _ = state.sheet.selectCell(cell)
    }
    
    func clickCell(_ cell: Cell) {
        switch state.sheet.isMultiSelectionMode() {
        case true:
            if state.sheet.isSelectedCell(cell) {
                _ = try! state.sheet.multiUnselectCell(cell)
                if !state.sheet.hasSelectedCell() {
                    state.sheet.switchSelectionMode()
                    state.isActivityMarkerControlBar = false
                } else {
                    state.isActivityMarkerControlBar = true
                }
            } else {
                _ = state.sheet.selectCell(cell)
            }
        case false:
            if state.sheet.isSelectedCell(cell) {
                state.sheet.unselectCell()
                state.isActivityMarkerControlBar = false
            } else {
                state.sheet.unselectCell()
                _ = state.sheet.selectCell(cell)
                state.isActivityMarkerControlBar = true
            }
        }
    }
}

struct MarkerControlBarUseCase {
    private var state: AppState
    
    init(state: AppState) {
        self.state = state
    }
    
    func chooseMainMarker(marker: MainMarker) {
        switch state.sheet.isMultiSelectionMode() {
        case true:
            if state.sheet.isEveryCellMarkedWithMainMarker(),
               state.sheet.isSameMainMarkerInEveryCell(marker) {
                state.sheet.getSelectedCells().forEach { cell in
                    cell.removeMainMarker()
                }
            } else {
                state.sheet.getSelectedCells().forEach { cell in
                    cell.setMainMarker(marker)
                }
            }
        case false:
            guard let cell = state.sheet.getSelectedCells().first else { return }
            
            if cell.equalsMainMarker(marker) {
                cell.removeMainMarker()
            } else {
                cell.setMainMarker(marker)
            }
        }
        state.isActivityMarkerControlBar = false
    }
    
    func cancelClickedCell() {
        if state.sheet.isMultiSelectionMode() {
            state.sheet.switchSelectionMode()
        }
        state.sheet.unselectCell()
    }
}
