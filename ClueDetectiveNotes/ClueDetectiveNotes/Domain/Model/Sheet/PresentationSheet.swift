//
//  PresentationSheet.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/14/24.
//

struct PresentationSheet {
    let cells: [PresentationCell]
    let isMultiMode: Bool
    let rowNames: [RowName]
    let colNames: [ColName]
    let selectedCells: [PresentationCell]
    let selectedRowNames: [CardType: RowName]
    let selectedColName: ColName?
    
    func isSelectedCell(_ cell: PresentationCell) -> Bool {
        return selectedCells.contains(cell)
    }
}
