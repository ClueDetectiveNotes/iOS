//
//  LoadSheetUseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/7/24.
//

struct LoadSheetUseCase {
    private var sheet: Sheet = GameSetter.shared.getSheetInstance()
    
    func execute() throws -> [String: Any] {
        return ["sheet": sheet]
    }
}
