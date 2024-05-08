//
//  LoadCellUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/8/24.
//

struct LoadCellUseCase {
    private var cell: Cell
    
    func execute() throws -> [String: Any] {
        return [
            "mainMarker": cell.getMainMarker() ?? "",
            "subMarkers": cell.getSubMarkers()
        ]
    }
}
