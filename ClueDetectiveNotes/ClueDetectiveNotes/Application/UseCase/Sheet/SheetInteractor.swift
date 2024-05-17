//
//  SheetInteractor.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

struct SheetInteractor {
    private var sheetStore: SheetStore
    private var sheet: Sheet = GameSetter.shared.getSheet()
    
    init(sheetStore: SheetStore) {
        self.sheetStore = sheetStore
    }
    
    func excute(_ useCase: SheetUseCase) {
        switch useCase {
        case let .clickCell(presentationCell):
            clickCell(presentationCell)
        case let .longClickCell(presentationCell):
            longClickCell(presentationCell)
        case let .clickColName(colName):
            clickColName(colName)
        case let .clickRowName(rowName):
            clickRowName(rowName)
        }
    }
}

extension SheetInteractor {
    private func clickCell(_ presentationCell: PresentationCell) {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        switch sheet.isMultiSelectionMode() {
        case true:
            if sheet.hasSelectedColName() && sheet.hasSelectedRowName() {
                resetSelectedState()
                sheetStore.setDisplayMarkerControlBar(false)
            } else {
                
                if sheet.isSelectedCell(cell) {
                    _ = try! sheet.multiUnselectCell(cell)
                    if !sheet.hasSelectedCell() {
                        sheet.switchSelectionMode()
                        sheetStore.setDisplayMarkerControlBar(false)
                    } else {
                        sheetStore.setDisplayMarkerControlBar(true)
                    }
                } else {
                    _ = sheet.selectCell(cell)
                }
            }
        case false:
            if sheet.isSelectedCell(cell) {
                sheet.unselectCell()
                sheetStore.setDisplayMarkerControlBar(false)
            } else {
                sheet.unselectCell()
                _ = sheet.selectCell(cell)
                sheetStore.setDisplayMarkerControlBar(true)
            }
        }
        
        updatePresentationSheet()
    }
    
    private func longClickCell(_ presentationCell: PresentationCell) {
        let cell = try! sheet.findCell(id: presentationCell.id)
        
        if !sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        if sheet.isSelectedCell(cell) {
            sheetStore.setDisplayMarkerControlBar(false)
        } else {
            _ = sheet.selectCell(cell)
            sheetStore.setDisplayMarkerControlBar(true)
        }
        
        updatePresentationSheet()
    }
    
    private func clickColName(_ colName: ColName) {
        if sheet.isSelectedColName(colName) {
            sheet.unselectColumnName()
        } else {
            _ = sheet.selectColumnName(colName)
        }
        
        selectIntersectionCells()
        updatePresentationSheet()
    }
    
    private func clickRowName(_ rowName: RowName) {
        if sheet.isSelectedRowName(rowName) {
            sheet.unselectRowName(rowName)
        } else {
            _ = sheet.selectRowName(rowName)
        }
        
        selectIntersectionCells()
        updatePresentationSheet()
    }
    
    private func selectIntersectionCells() {
        if sheet.hasSelectedColName() && sheet.hasSelectedRowName() {
            let cells = try! sheet.getCellsIntersectionOfSelection()
            
            sheet.unselectCell()
            if !sheet.isMultiSelectionMode() {
                sheet.switchSelectionMode()
            }
            
            for cell in cells {
                _ = sheet.selectCell(cell)
            }
            sheetStore.setDisplayMarkerControlBar(true)
        } else {
            sheetStore.setDisplayMarkerControlBar(false)
        }
    }
    
    private func resetSelectedState() {
        if sheet.isMultiSelectionMode() {
            sheet.switchSelectionMode()
        }
        
        sheet.unselectCell()
        sheet.unselectColumnName()
        sheet.getSelectedRowNames().values.forEach { rowName in
            sheet.unselectRowName(rowName)
        }
    }
    
    private func updatePresentationSheet() {
        let presentationSheet = PresentationSheet(
            cells: sheet.getCellsImmutable(),
            isMultiMode: sheet.isMultiSelectionMode(),
            rowNames: sheet.getRowNames(),
            colNames: sheet.getColNames(),
            selectedCells: sheet.getSelectedCellsImmutable(),
            selectedRowNames: sheet.getSelectedRowNames(),
            selectedColName: sheet.getSelectedColName()
        )
        
        sheetStore.overwriteSheet(presentationSheet)
    }
}
