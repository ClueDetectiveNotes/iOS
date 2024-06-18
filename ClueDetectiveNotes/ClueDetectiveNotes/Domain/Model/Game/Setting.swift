//
//  Setting.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 5/17/24.
//

final class Setting {
    private var players: [Player]
    private var edition: Edition
    private var subMarkerTypes: [SubMarker]
    
    init(
        players: [Player] = [
            Player(id: 1, name: "Player 1"),
            Player(id: 2, name: "Player 2"),
            Player(id: 3, name: "Player 3")
        ].sorted { $0.id < $1.id },
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
