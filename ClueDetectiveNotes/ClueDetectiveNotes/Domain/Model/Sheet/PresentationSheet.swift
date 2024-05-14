//
//  PresentationSheet.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/14/24.
//

struct PresentationSheet {
    let cells: [Cell]
    let isMultiMode: Bool
    let rowNames: [RowName]
    let colNames: [ColName]
    let selectedCells: [Cell]
    let selectedRowNames: [CardType: RowName]
    let selectedColName: ColName?
    
    func isSelectedCell(_ cell: Cell) -> Bool {
        return selectedCells.contains(cell)
    }
}
