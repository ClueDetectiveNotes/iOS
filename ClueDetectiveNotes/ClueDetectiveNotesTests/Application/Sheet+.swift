//
//  Sheet+.swift
//  ClueDetectiveNotesTests
//
//  Created by Dasan & Mary on 5/25/24.
//

@testable import ClueDetectiveNotes

extension Sheet {
    func getCellImmutable(cell: Cell) -> PresentationCell {
        return PresentationCell(
            id: cell.getID(),
            rowName: cell.getRowName(),
            colName: cell.getColName(),
            mainMarker: cell.getMainMarker(),
            subMarkers: cell.getSubMarkers(),
            isLock: cell.getIsLock(),
            isInit: cell.getIsInit()
        )
    }
}
