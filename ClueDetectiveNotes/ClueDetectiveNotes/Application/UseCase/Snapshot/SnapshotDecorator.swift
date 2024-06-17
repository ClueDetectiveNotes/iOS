//
//  SnapshotDecorator.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/14/24.
//

final class SnapshotDecorator<T: UseCase>: UseCaseDecorator<T> {
    private let snapshotManager = SnapshotManager.shared
    
    override init(_ wrappee: T) {
        super.init(wrappee)
    }
    
    override func execute(_ value: T.value) throws -> PresentationSheet {
        let result = try super.execute(value)
        snapshotManager.takeSnapshot()
        return result
    }
}
