//
//  SnapshotManager.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/13/24.
//

final class SnapshotManager {
    static let shared = SnapshotManager()
    
    private var tempSnapshot: Snapshot
    private var snapshotUndoStack = [Snapshot]()
    private var snapshotRedoStack = [Snapshot]()
    private var restoreUndoStack = [Snapshot]()
    
    private init(tempSnapshot: Snapshot = Snapshot()) {
        self.tempSnapshot = tempSnapshot
    }
    
    func takeSnapshot() {
        snapshotRedoStack.removeAll()
        snapshotUndoStack.append(tempSnapshot)
        tempSnapshot = Snapshot()
    }
    
    func popOffUndoSnapshot() throws -> Snapshot {
        guard !snapshotUndoStack.isEmpty else {
            throw SnapshotError.snapshotStackIsEmpty
        }
        
        snapshotRedoStack.append(tempSnapshot)
        tempSnapshot = snapshotUndoStack.removeLast()
        
        return tempSnapshot
    }
    
    func popOffRedoSnapshot() throws -> Snapshot {
        guard !snapshotRedoStack.isEmpty else {
            throw SnapshotError.snapshotStackIsEmpty
        }
        
        snapshotUndoStack.append(tempSnapshot)
        tempSnapshot = snapshotRedoStack.removeLast()
        
        return tempSnapshot
    }
    
    func lockSnapshot() {
        restoreUndoStack.append(contentsOf: snapshotUndoStack)
        snapshotUndoStack.removeAll()
        snapshotRedoStack.removeAll()
    }
    
    func unlockSnapshot() {
        restoreUndoStack.append(contentsOf: snapshotUndoStack)
        snapshotUndoStack.removeAll()
        snapshotUndoStack.append(contentsOf: restoreUndoStack)
        restoreUndoStack.removeAll()
    }
}
