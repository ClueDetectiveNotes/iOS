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
    
    func getPlayers() -> [any Player] {
        return players.sorted { $0.id < $1.id }
    }
    
    func getPlayersWithoutSolution() -> [any Player] {
        return players
            .filter { !($0 is Solution) }
            .sorted { $0.id < $1.id }
    }
    
    func getPlayerCount() -> Int {
        return players.count
    }
    
    func getPlayersCountWithoutSolution() -> Int {
        return players.filter { !($0 is Solution) }.count
    }
    
    func getMinPlayerCount() -> Int {
        return playerCountRange.lowerBound
    }
    
    func getMaxPlayerCount() -> Int {
        return playerCountRange.upperBound
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
    
    func addPlayer(id: Int, name: String, type: PlayerType) throws {
        let trimmingName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmingName.isEmpty else {
            throw SettingError.nameIsEmpty
        }
        
        guard !isDuplicatePlayer(id: id, name: name) else {
            throw SettingError.alreadyExistsPlayer
        }
        
        var player: any Player
        
        switch type {
        case .user:
            player = User(id: id, name: name)
        case .other:
            player = Other(id: id, name: name)
        case .solution:
            player = Solution(id: id, name: name)
        }
        
        players.append(player)
    }
}

extension Setting {
    private func isValidSubMarkerNotation(_ notation: String) -> Bool {
        return !notation.isEmpty && notation.count <= 2
    }
    
    private func isDuplicatePlayer(id: Int, name: String) -> Bool {
        for player in players {
            if player.id == id || player.name == name {
                return true
            }
        }
        return false
    }
}
