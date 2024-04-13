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
    
    func hasSelectedCell() -> Bool {
        return !selectedCells.isEmpty
    }
    
    mutating func selectCell(rowName: RowName, colName: ColName) -> Cell? {
        guard let selectedCell = findCell(rowName: rowName, colName: colName) else { return nil }
        
        selectedCells.append(selectedCell)
        
        return selectedCell
    }
    
    private func findCell(rowName: RowName, colName: ColName) -> Cell? {
        for cell in cells {
            if cell.rowName == rowName,
               cell.colName == colName {
                return cell
            }
        }

        return nil
    }
    
    func getRowNames() -> [RowName] {
        return rowNames
    }
    
    func getColNames() -> [ColName] {
        return colNames
    }
}

struct RowName: Hashable {
    let card: DefaultCard
}

struct ColName: Hashable {
    let player: Player
}
