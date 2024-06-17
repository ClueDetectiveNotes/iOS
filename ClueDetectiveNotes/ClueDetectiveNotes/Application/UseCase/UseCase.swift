//
//  UseCase.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/13/24.
//

protocol UseCase {
    associatedtype value
    
    func execute(_ value: value) throws -> PresentationSheet
}

extension UseCase where value == Int {
    func execute(_ value: value = 0) throws -> PresentationSheet {
        try execute(value)
    }
}

class AnyUseCase<V>: UseCase {
    typealias value = V
    
    private let _execute: (V) throws -> PresentationSheet
    
    init<T: UseCase>(_ useCase: T) where T.value == V {
        self._execute = useCase.execute
    }
    
    func execute(_ value: V) throws -> PresentationSheet {
        return try _execute(value)
    }
}
