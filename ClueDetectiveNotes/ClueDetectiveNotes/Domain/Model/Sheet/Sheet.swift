//
//  Sheet.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

import Foundation

final class Sheet {
    private var cells = [Cell]()
    private var mode: SheetMode
    private var rowNames = [RowName]()
    private var colNames = [ColName]()
    private var selectedCells = [Cell]()
    private var selectedRowNames = [CardType: RowName]()
    private var selectedColName: ColName?
    private var isCellsLocked: Bool
    
    init (
        cardHolders: CardHolders,
        cards: Deck,
        mode: SheetMode = .single,
        isCellsLocked: Bool = false
    ) {
        self.mode = mode
        self.isCellsLocked = isCellsLocked
        
        var tempHolders: [CardHolder] = cardHolders.getPlayers()
        tempHolders.append(cardHolders.getAnswer())
        
        tempHolders.forEach { holder in
            colNames.append(ColName(cardHolder: holder))
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
    
    // MARK: - State
    func isSingleMode() -> Bool {
        return mode == .single
    }
    
    func isMultiMode() -> Bool {
        return mode == .multi
    }
    
    func isInferenceMode() -> Bool {
        return mode == .inference
    }
    
    func isPreInferenceMode() -> Bool {
        return mode == .preInference
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
    
    func isSelectedCell(_ cell: Cell) -> Bool {
        return selectedCells.contains(cell)
    }
    
    func isSelectedCell(rowName: RowName, colName: ColName) throws -> Bool {
        let cell = try findCell(rowName: rowName, colName: colName)
        return selectedCells.contains(cell)
    }
    
    func isSelectedRowName(_ rowName: RowName) -> Bool {
        return selectedRowNames.values.contains(rowName)
    }
    
    func isSelectedColName(_ colName: ColName) -> Bool {
        return selectedColName == colName
    }
    
    func isEveryCellMarkedWithMainMarker() -> Bool {
        return selectedCells.allSatisfy { selectedCell in
            !selectedCell.isEmptyMainMarker()
        }
    }
    
    func isSameMainMarkerInEveryCell(_ marker: MainMarker) -> Bool {
        let markedCells = selectedCells.filter { !$0.isEmptyMainMarker() }
        
        return markedCells.allSatisfy { markedCell in
            markedCell.getMainMarker() == marker
        }
    }
    
    func isEveryCellMarkedWithSameSubMarker(_ marker: SubMarker) -> Bool {
        return selectedCells.allSatisfy { selectedCell in
            selectedCell.containsSubMarker(marker)
        }
    }
    
    // MARK: - GET
    func getCells() -> [Cell] {
        return cells
    }
    
    func getMode() -> SheetMode {
        return mode
    }
    
    func getRowNames() -> [RowName] {
        return rowNames
    }
    
    func getColNames() -> [ColName] {
        return colNames
    }
    
    func getNextColName(_ currentColName: ColName) -> ColName {
        var nextIndex = 0
        let gap = 1
        
        for (index, colName) in colNames.enumerated() {
            if currentColName == colName {
                if index == colNames.count - 1 {
                    nextIndex = 0
                } else {
                    nextIndex = (index + gap) % (colNames.count-1)
                }
                break
            }
        }
        
        return colNames[nextIndex]
    }
    
    func getPreviousColName(_ currentColName: ColName) -> ColName {
        var previousIndex = 0
        let gap = colNames.count - 2
        
        for (index, colName) in colNames.enumerated() {
            if currentColName == colName {
                if index == colNames.count - 1 {
                    previousIndex = gap
                } else {
                    previousIndex = (index + gap) % (colNames.count-1)
                }
                break
            }
        }
        
        return colNames[previousIndex]
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
    
    func getRowCells(_ rowName: RowName) -> [Cell] {
        return cells.filter { cell in
            cell.getRowName() == rowName
        }
    }
    
    func findCell(id: UUID) throws -> Cell {
        if let cell = cells.filter({ $0.getID() == id }).first {
            return cell
        } else {
            throw SheetError.cellNotFound
        }
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
    
    func getIsCellsLocked() -> Bool {
        return isCellsLocked
    }
    
    // MARK: - SET
    func switchMode(_ mode: SheetMode) {
        guard self.mode != mode else { return }
        
        if hasSelectedCell() && (isMultiMode() || isInferenceMode()) {
            unselectCell()
        }
        
        self.mode = mode
    }
    
    func switchModeInInferenceMode() throws {
        if !hasSelectedColName(), !hasSelectedRowName() {
            switchMode(.single)
        } else if hasSelectedColName(), selectedRowNames.count == 3 {
            switchMode(.inference)
            selectedCells.append(contentsOf: try getCellsIntersectionOfSelection())
        } else {
            switchMode(.preInference)
        }
    }
    
    func switchModeInSelectionMode() {
        hasSelectedCell() ? switchMode(.multi) : switchMode(.single)
    }
    
    func selectCell(_ cell: Cell) throws -> [Cell] {
        guard !isInferenceMode(), !isPreInferenceMode() else {
            throw SheetError.inferenceModeException
        }
        
        selectedCells.append(cell)
        
        return selectedCells
    }
    
    func selectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        guard !isInferenceMode(), !isPreInferenceMode() else {
            throw SheetError.inferenceModeException
        }
        
        let selectedCell = try findCell(rowName: rowName, colName: colName)
        
        selectedCells.append(selectedCell)
        
        return selectedCells
    }
    
    func unselectCell() {
        selectedCells.removeAll()
    }
    
    func multiSelectCell(_ cell: Cell) throws -> [Cell] {
        guard !isInferenceMode(), !isPreInferenceMode() else {
            throw SheetError.inferenceModeException
        }
        guard isMultiMode() else {
            throw SheetError.notMultiSelectionMode
        }
        guard !isSelectedCell(cell) else {
            throw SheetError.cannotSelectAlreadySelectedCell
        }
        
        selectedCells.append(cell)
        
        return selectedCells
    }
    
    func multiSelectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        guard !isInferenceMode(), !isPreInferenceMode() else {
            throw SheetError.inferenceModeException
        }
        guard isMultiMode() else {
            throw SheetError.notMultiSelectionMode
        }
        guard try !isSelectedCell(rowName: rowName, colName: colName) else {
            throw SheetError.cannotSelectAlreadySelectedCell
        }
        
        let cell = try findCell(rowName: rowName, colName: colName)
        selectedCells.append(cell)

        return selectedCells
    }
    
    func multiUnselectCell(_ cell: Cell) throws -> [Cell] {
        guard isMultiMode() else {
            throw SheetError.notMultiSelectionMode
        }
        guard isSelectedCell(cell) else {
            throw SheetError.cannotUnselectNeverChosenCell
        }
        
        if let index = selectedCells.firstIndex(where: { $0 == cell }) {
            selectedCells.remove(at: index)
        }
        
        return selectedCells
    }
    
    func multiUnselectCell(rowName: RowName, colName: ColName) throws -> [Cell] {
        guard isMultiMode() else {
            throw SheetError.notMultiSelectionMode
        }
        guard try isSelectedCell(rowName: rowName, colName: colName) else {
            throw SheetError.cannotUnselectNeverChosenCell
        }
        
        let cell = try findCell(rowName: rowName, colName: colName)
        if let index = selectedCells.firstIndex(where: { $0 == cell }) {
            selectedCells.remove(at: index)
        }
        
        return selectedCells
    }
    
    func selectRowName(_ rowName: RowName) -> [Cell] {
        let type = rowName.card.type
        
        selectedRowNames[type] = rowName
        
        return cells.filter { cell in
            cell.getRowName() == rowName
        }
    }
    
    func unselectRowName(_ rowName: RowName) {
        let type = rowName.card.type
        
        selectedRowNames[type] = nil
    }
    
    func selectColumnName(_ colName: ColName) -> [Cell] {
        selectedColName = colName
        
        return cells.filter { cell in
            cell.getColName() == colName
        }
    }
    
    func unselectColumnName() {
        selectedColName = nil
    }
    
    func resetSelectedState() {
        if !isSingleMode() {
            switchMode(.single)
        }
        
        unselectCell()
        unselectColumnName()
        getSelectedRowNames().values.forEach { rowName in
            unselectRowName(rowName)
        }
    }
    
    func lockCells() {
        cells.forEach { cell in
            cell.lock()
        }
        isCellsLocked = true
    }
    
    func unlockCells() {
        cells.forEach { cell in
            cell.unlock()
        }
        isCellsLocked = false
    }
}

struct RowName: Hashable {
    let card: Card
}

struct ColName: Hashable {
    let cardHolder: CardHolder
    
    static func == (lhs: ColName, rhs: ColName) -> Bool {
        lhs.cardHolder.id == rhs.cardHolder.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(cardHolder.id)
    }
}
