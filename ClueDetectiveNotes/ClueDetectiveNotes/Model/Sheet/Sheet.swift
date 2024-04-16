//
//  Sheet.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

struct Sheet {
    private var rowNames = [RowName]()
    private var colNames = [ColName]()
    private var cells = Set<Cell>()
    private var selectedCells = [Cell]()
    private var isMultiMode: Bool = false
    
    init(
        players: [Player]
    ) {
        players.forEach { player in
            self.colNames.append(ColName(player: player))
        }
        
        DefaultCard.allCases.forEach { card in
            self.rowNames.append(RowName(card: card))
        }
        
        for rowName in rowNames {
            for colName in colNames {
                let cell = Cell(
                    rowName: rowName,
                    colName: colName
                )
                
                cells.insert(cell)
            }
        }
    }
    
    func getRowNames() -> [RowName] {
        return rowNames
    }
    
    func getColNames() -> [ColName] {
        return colNames
    }
    
    func hasSelectedCell() -> Bool {
        return !selectedCells.isEmpty
    }
    
    func isMultiSelectionMode() -> Bool {
        return isMultiMode
    }
    
    mutating func selectCell(rowName: RowName, colName: ColName) throws -> Cell {
        let selectedCell = try findCell(rowName: rowName, colName: colName)
        
        selectedCells.append(selectedCell)
        
        return selectedCell
    }
    
    mutating func unselectCell(rowName: RowName, colName: ColName) {
        if isMultiMode {
            
        } else {
            selectedCells.removeAll()
        }
    }
    
    private func findCell(rowName: RowName, colName: ColName) throws -> Cell {
        for cell in cells {
            if cell.rowName == rowName,
               cell.colName == colName {
                return cell
            }
        }

        throw SheetError.cellNotFound
    }
    
    mutating func switchSelectionMode() {
        if isMultiMode, !selectedCells.isEmpty {
            selectedCells.removeAll()
        }
        
        isMultiMode.toggle()
    }
    
    mutating func multiSelectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        guard isMultiMode else { throw SheetError.notMultiSelectionMode }
        let cell = try findCell(rowName: rowName, colName: colName)

        if let index = selectedCells.firstIndex(of: cell) {
            selectedCells.remove(at: index)
        } else {
            selectedCells.append(cell)
        }
        
        return selectedCells
    }
    
    func selectRow(_ rowName: RowName) -> [Cell] {
        return cells.filter { cell in
            cell.rowName == rowName
        }
    }
    
    func selectColumn(_ colName: ColName) -> [Cell] {
        return cells.filter { cell in
            cell.colName == colName
        }
    }
}

struct RowName: Hashable {
    let card: DefaultCard
}

struct ColName: Hashable {
    let player: Player
}
