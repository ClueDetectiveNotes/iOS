//
//  MarkerControlBarStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/9/24.
//

import Foundation

final class MarkerControlBarStore: ObservableObject {
    private var chooseCrossMarkerUseCase = ChooseMainMarkerUseCase(marker: .init(notation: .cross))
    private var chooseQuestionMarkerUseCase = ChooseMainMarkerUseCase(marker: .init(notation: .question))
    private var cancelClickedCellUseCase = CancelClickedCellUseCase()
    
    func onClickCrossMarker() {
        try? chooseCrossMarkerUseCase.execute()
    }
    
    func onClickQuestionMaker() {
        try? chooseQuestionMarkerUseCase.execute()
    }
    
    func cancelClickedCells() {
        try? cancelClickedCellUseCase.execute()
    }
}
