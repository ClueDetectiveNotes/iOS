//
//  CellStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/9/24.
//

import Foundation

final class CellStore: ObservableObject {
    @Published var cell: Cell
    
    init(cell: Cell) {
        self.cell = cell
    }
}
