//
//  SheetStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

final class SheetStore: ObservableObject {
    @Published var cells = [Cell]()
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
    
    func isMultiSelectionMode() -> Bool {
        return isMultiMode
    }
    
    func cellTapped(_ cell: Cell) {
        if let index = selectedCells.firstIndex(where: { $0.id == cell.id }) {
            selectedCells.remove(at: index)
        } else {
            if isMultiMode {
                selectedCells.append(cell)
            } else if selectedCells.isEmpty {
                selectedCells.append(cell)
            } else {
                selectedCells.removeAll()
            }
        }
    }
    
    func selectCell(rowName: RowName, colName: ColName) throws -> Cell {
        let selectedCell = try findCell(rowName: rowName, colName: colName)
        
        selectedCells.append(selectedCell)
        
        return selectedCell
    }
    
    func unselectCell(rowName: RowName, colName: ColName) {
        if isMultiMode {
            
        } else {
            selectedCells.removeAll()
        }
    }
    
    func multiSelectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        guard isMultiMode else { throw SheetError.notMultiSelectionMode }
        
        let cell = try findCell(rowName: rowName, colName: colName)

        if let index = selectedCells.firstIndex(where: { $0.id == cell.id }) {
            selectedCells.remove(at: index)
        } else {
            selectedCells.append(cell)
        }
        
        return selectedCells
    }
    
    func findCell(rowName: RowName, colName: ColName) throws -> Cell {
        for cell in cells {
            if cell.getRowName() == rowName,
               cell.getColName() == colName {
                return cell
            }
        }

        throw SheetError.cellNotFound
    }
    
    func switchSelectionMode() {
        if isMultiMode, !selectedCells.isEmpty {
            selectedCells.removeAll()
        }
        
        isMultiMode.toggle()
    }
    
    func selectRow(_ rowName: RowName) {
        let type = rowName.card.type
        
        if selectedRowNames[type] == rowName {
            selectedRowNames[type] = nil
        } else {
            selectedRowNames[type] = rowName
        }
    }
    
    func selectColumn(_ colName: ColName) {
        if selectedColName == colName {
            selectedColName = nil
        } else {
            selectedColName = colName
        }
    }
    
    func getCellsInSelectedRowAndColumn(intersectionOnly: Bool) -> [Cell] {
        let rowNames = selectedRowNames.values
        let colName = selectedColName
        
        if intersectionOnly {
            return cells.filter { cell in
                rowNames.contains(cell.getRowName()) && cell.getColName() == colName
            }
        } else {
            return cells.filter { cell in
                rowNames.contains(cell.getRowName()) || cell.getColName() == colName
            }
        }
    }
}

struct RowName: Hashable {
    let card: ClueCard
}

struct ColName: Hashable {
    let player: Player
}
