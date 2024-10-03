//
//  SubMarkerType.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/18/24.
//

final class SubMarkerType {
    static let shared = SubMarkerType()
    
    private var types: [String] = []
    
    private init() { }
    
    func getSubMarkerTypes() -> [String] {
        if types.isEmpty {
            types = ["1", "2", "3", "4"]
        }
        
        return types
    }
    
    func addSubMarkerType(_ notation: String) throws {
        let tempNotation = notation.replacingOccurrences(of: " ", with: "")
        
        guard types.contains(tempNotation) else {
            throw CellError.alreadyContainsSubMarker
        }
        
        types.append(tempNotation)
    }
}
