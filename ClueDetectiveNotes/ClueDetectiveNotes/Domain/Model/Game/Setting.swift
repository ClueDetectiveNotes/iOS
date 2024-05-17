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
        players: [Player] = [Player(name: "Player 1"), Player(name: "Player 2"), Player(name: "Player 3")],
        edition: Edition = .classic,
        subMarkerTypes: [SubMarker] = [SubMarker(notation: "1"), SubMarker(notation: "2"), SubMarker(notation: "3"), SubMarker(notation: "4")]
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
    
    func addSubMarkerType(_ marker: SubMarker) {
        subMarkerTypes.append(marker)
    }
}
