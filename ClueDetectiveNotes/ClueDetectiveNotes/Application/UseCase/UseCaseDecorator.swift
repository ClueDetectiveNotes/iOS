//
//  UseCaseDecorator.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/14/24.
//

class UseCaseDecorator<T: UseCase>: UseCase {
    typealias value = T.value
    
    private let wrappee: T
    
    init(_ wrappee: T) {
        self.wrappee = wrappee
    }
    
    func execute(_ value: T.value) throws -> PresentationSheet {
        return try wrappee.execute(value)
    }
}
