//
//  SheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

enum SheetUseCase {
    case clickCell(_ presentationCell: PresentationCell)
    case longClickCell(_ presentationCell: PresentationCell)
    case clickColName(_ colName: ColName)
    case clickRowName(_ rowName: RowName)
}
