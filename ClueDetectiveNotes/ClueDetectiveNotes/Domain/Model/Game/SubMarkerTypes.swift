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
        SubMarkerType(notation: "0", isUse: true, isDefault: true),
        SubMarkerType(notation: "1", isUse: true, isDefault: true),
        SubMarkerType(notation: "2", isUse: true, isDefault: true),
        SubMarkerType(notation: "3", isUse: true, isDefault: true),
        SubMarkerType(notation: "4", isUse: true, isDefault: true),
        SubMarkerType(notation: "5", isUse: true, isDefault: true),
        SubMarkerType(notation: "6", isUse: true, isDefault: true),
        SubMarkerType(notation: "7", isUse: true, isDefault: true),
        SubMarkerType(notation: "8", isUse: true, isDefault: true),
        SubMarkerType(notation: "9", isUse: true, isDefault: true),
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
    
    func addSubMarkerType(_ notation: String) throws {
        let tempNotation = notation.replacingOccurrences(of: " ", with: "")
        
        guard !tempNotation.isEmpty else {
            throw SubMarkerTypesError.subMarkerIsEmpty
        }
        
        if let index = types.firstIndex(where: { $0.notation == tempNotation }) {
            
            // 비활성화 상태이면 활성화로 바꿔주기
            if types[index].isUse == false {
                types[index].isUse = true
            } else {
                // 활성화 상태이면 에러
                throw SubMarkerTypesError.alreadyContainsSubMarker
            }
        } else {
            let newSubMarkerType = SubMarkerType(
                notation: notation,
                isUse: true,
                isDefault: false
            )
            
            types.append(newSubMarkerType)
        }
    }
    
    func removeSubMarkerType(_ indexSet: IndexSet) throws {
        guard !types.isEmpty else {
            throw SubMarkerTypesError.subMarkerIsEmpty
        }
        
        guard types.count > 1 else {
            throw SubMarkerTypesError.remainingSingleSubMarker
        }
        
        types.remove(atOffsets: indexSet)
    }
    
    func reorderSubMarkerTypes(source: IndexSet, destination: Int) {
        types.move(fromOffsets: source, toOffset: destination)
    }
    
    func toggleSubMarkerType(_ subMarkerType: SubMarkerType) throws {
        guard !types.isEmpty else {
            throw SubMarkerTypesError.subMarkerIsEmpty
        }
        
        if let index = types.firstIndex(where: { $0.notation == subMarkerType.notation }) {
            types[index].isUse.toggle()
        }
    }
}
