//
//  SubMarkerTypes.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

import Foundation

final class SubMarkerTypes {
    static let shared = SubMarkerTypes()
    
    private var types: [SubMarkerType] = []
    private var defaultSubMarkerTypes = [
        SubMarkerType(notation: "1", isUse: true),
        SubMarkerType(notation: "2", isUse: true),
        SubMarkerType(notation: "3", isUse: true),
        SubMarkerType(notation: "4", isUse: true)
    ]
    
    private init() { }
    
    func getSubMarkerTypes() -> [SubMarkerType] {
        if types.isEmpty {
            types = defaultSubMarkerTypes
        }
        
        return types
    }
    
    func initSubMarkerType() {
        types = defaultSubMarkerTypes
    }
    
    // DOTO: - Type 에러 분리할까
    func addSubMarkerType(_ notation: String) throws {
        let tempNotation = notation.replacingOccurrences(of: " ", with: "")
        
        guard !tempNotation.isEmpty else {
            throw CellError.subMarkerIsEmpty
        }
        
        guard !types.contains(where: {$0.notation == tempNotation}) else {
            throw CellError.alreadyContainsSubMarker
        }
        
        let newSubMarkerType = SubMarkerType(notation: notation, isUse: true)
        types.append(newSubMarkerType)
    }
    
    func removeSubMarkerType(_ indexSet: IndexSet) throws {
        guard !types.isEmpty else {
            throw CellError.subMarkerIsEmpty
        }
        
        types.remove(atOffsets: indexSet)
    }
    
    func reorderSubMarkerTypes(source: IndexSet, destination: Int) {
        types.move(fromOffsets: source, toOffset: destination)
    }
    
    func toggleSubMarkerType(_ subMarkerType: SubMarkerType) throws {
        guard !types.isEmpty else {
            throw CellError.subMarkerIsEmpty
        }
        
        if let index = types.firstIndex(where: { $0.notation == subMarkerType.notation }) {
            types[index].isUse.toggle()
        }
    }
}
