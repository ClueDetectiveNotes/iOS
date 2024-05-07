//
//  Sheet.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

struct Sheet {
    private var cells = [Cell]()
    private var isMultiMode: Bool
    private var rowNames = [RowName]()
    private var colNames = [ColName]()
    private var selectedCells = [Cell]()
    private var selectedRowNames = [CardType: RowName]()
    private var selectedColName: ColName?
    
    init(
        players: [Player],
        cards: Cards,
        isMultiMode: Bool = false
    ) {
        self.isMultiMode = isMultiMode
        
        players.forEach { player in
            colNames.append(ColName(player: player))
        }

        cards.allCards().forEach { card in
            rowNames.append(RowName(card: card))
        }

        for rowName in rowNames {
            for colName in colNames {
                let cell = Cell(
                    rowName: rowName,
                    colName: colName
                )
                cells.append(cell)
            }
        }
    }
    
    func getCells() -> [Cell] {
        return cells
    }
    
    func getRowNames() -> [RowName] {
        return rowNames
    }
    
    func getColNames() -> [ColName] {
        return colNames
    }
    
    func getSelectedCells() -> [Cell] {
        return selectedCells
    }
    
    func getSelectedRowNames() -> [CardType:RowName] {
        return selectedRowNames
    }
    
    func getSelectedColName() -> ColName? {
        return selectedColName
    }
    
    func hasSelectedCell() -> Bool {
        return !selectedCells.isEmpty
    }
    
    func hasSelectedRowName() -> Bool {
        return !selectedRowNames.isEmpty
    }
    
    func hasSelectedColName() -> Bool {
        return selectedColName != nil
    }
    
    func isSelectedRowName(_ rowName: RowName) -> Bool {
        return selectedRowNames.values.contains(rowName)
    }
    
    func isSelectedColName(_ colName: ColName) -> Bool {
        return selectedColName == colName
    }
    
    func isMultiSelectionMode() -> Bool {
        return isMultiMode
    }
    
    mutating func selectCell(_ cell: Cell) -> [Cell] {
        selectedCells.append(cell)
        
        return selectedCells
    }
    
    mutating func selectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        let selectedCell = try findCell(rowName: rowName, colName: colName)
        
        selectedCells.append(selectedCell)
        
        return selectedCells
    }
    
    private func findCell(rowName: RowName, colName: ColName) throws -> Cell {
        for cell in cells {
            if cell.getRowName() == rowName,
               cell.getColName() == colName {
                return cell
            }
        }
        
        throw SheetError.cellNotFound
    }
    
    mutating func unselectCell() {
        selectedCells.removeAll()
    }
    
    mutating func switchSelectionMode() {
        if isMultiSelectionMode(), hasSelectedCell() {
            unselectCell()
        }
        
        isMultiMode.toggle()
    }
    
    mutating func multiSelectCell(_ cell: Cell) throws -> [Cell] {
        guard isMultiSelectionMode() else { throw SheetError.notMultiSelectionMode }
        guard !isSelectedCell(cell) else {
            throw SheetError.cannotSelectAlreadySelectedCell
        }
        
        selectedCells.append(cell)
        
        return selectedCells
    }
    
    mutating func multiSelectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        guard isMultiSelectionMode() else { throw SheetError.notMultiSelectionMode }
        guard try !isSelectedCell(rowName: rowName, colName: colName) else {
            throw SheetError.cannotSelectAlreadySelectedCell
        }
        
        let cell = try findCell(rowName: rowName, colName: colName)
        selectedCells.append(cell)

        return selectedCells
    }
    
    mutating func multiUnselectCell(_ cell: Cell) throws -> [Cell] {
        guard isMultiSelectionMode() else { throw SheetError.notMultiSelectionMode }
        guard isSelectedCell(cell) else {
            throw SheetError.cannotUnselectNeverChosenCell
        }
        
        if let index = selectedCells.firstIndex(where: { $0 == cell }) {
            selectedCells.remove(at: index)
        }
        
        return selectedCells
    }
    
    mutating func multiUnselectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        guard isMultiSelectionMode() else { throw SheetError.notMultiSelectionMode }
        guard try isSelectedCell(rowName: rowName, colName: colName) else {
            throw SheetError.cannotUnselectNeverChosenCell
        }
        
        let cell = try findCell(rowName: rowName, colName: colName)
        if let index = selectedCells.firstIndex(where: { $0 == cell }) {
            selectedCells.remove(at: index)
        }
        
        return selectedCells
    }
    
    func isSelectedCell(_ cell: Cell) -> Bool {
        return selectedCells.contains(cell)
    }
    
    func isSelectedCell(rowName: RowName, colName: ColName) throws -> Bool {
        let cell = try findCell(rowName: rowName, colName: colName)
        return selectedCells.contains(cell)
    }

    mutating func selectRowName(_ rowName: RowName) -> [Cell] {
        let type = rowName.card.type
        
        selectedRowNames[type] = rowName

        return cells.filter { cell in
            cell.getRowName() == rowName
        }
    }
    
    mutating func unselectRowName(_ rowName: RowName) {
        let type = rowName.card.type
        
        selectedRowNames[type] = nil
    }
    
    mutating func selectColumnName(_ colName: ColName) -> [Cell] {
        selectedColName = colName
        
        return cells.filter { cell in
            cell.getColName() == colName
        }
    }
    
    mutating func unselectColumnName() {
        selectedColName = nil
    }
    
    func getCellsIntersectionOfSelection() throws -> [Cell] {
        let rowNames = selectedRowNames.values
        let colName = selectedColName
        
        guard let colName else {
            throw SheetError.notYetSelectAnyColumnName
        }
        guard !rowNames.isEmpty else {
            throw SheetError.notYetSelectAnyRowName
        }
        
        return cells.filter { cell in
            rowNames.contains(cell.getRowName()) && cell.getColName() == colName
        }
    }
}

struct RowName: Hashable {
    let card: ClueCard
}

struct ColName: Hashable {
    let player: Player
}
