//
//  Setting.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

final class Setting {
    private var players: [any Player]
    private var edition: Edition
    private var subMarkerTypes: [SubMarker]
    
    private let playerCountRange = 3...6
    
    init(
        players: [any Player] = [any Player](),
        edition: Edition = .classic,
        subMarkerTypes: [SubMarker] = [
            SubMarker(notation: "1"),
            SubMarker(notation: "2"),
            SubMarker(notation: "3"),
            SubMarker(notation: "4")
        ]
    ) {
        self.players = players
        self.edition = edition
        self.subMarkerTypes = subMarkerTypes
    }
    
    func getPlayers() -> [Player] {
        return players
    }
    
    func getEdition() -> Edition {
        return edition
    }
    
    func getSubMarkerTypes() -> [SubMarker] {
        return subMarkerTypes
    }
    
    func addSubMarkerType(_ marker: SubMarker) throws {
        let notation = marker.notation.replacingOccurrences(of: " ", with: "")
        
        guard isValidSubMarkerNotation(notation) else {
            throw SettingError.invalidSubMarkerType
        }
        
        guard !subMarkerTypes.contains(SubMarker(notation: notation)) else {
            throw SettingError.alreadyExistsSubMarkerType
        }
        
        subMarkerTypes.append(SubMarker(notation: notation))
    }
    
    private func isValidSubMarkerNotation(_ notation: String) -> Bool {
        return !notation.isEmpty && notation.count <= 2
    }
}
