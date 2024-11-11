//
//  PresentationCell.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/14/24.
//

import Foundation

struct PresentationCell {
    let id: UUID
    let rowName: RowName
    let colName: ColName
    let mainMarker: MainMarker?
    let subMarkers: [SubMarker]
    let isLock: Bool
    
    func isAnswer() -> Bool {
        return !(self.colName.cardHolder is Player)
    }
}

extension PresentationCell: Hashable {
    static func == (lhs: PresentationCell, rhs: PresentationCell) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
