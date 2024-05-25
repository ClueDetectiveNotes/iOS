//
//  UseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

protocol UseCase {
    associatedtype value
    
    func execute(_ value: value) -> PresentationSheet
}

extension UseCase where value == Int {
    func execute(_ value: value = 0) -> PresentationSheet {
        execute(value)
    }
}
