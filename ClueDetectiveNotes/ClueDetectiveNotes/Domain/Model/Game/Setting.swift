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
    private var publicCards: [Card]
    private var myCards: [Card]
    
    private let playerCountRange = 3...6
    
    init(
        players: [Player] = [Player](),
        edition: Edition = .classic,
        subMarkerTypes: [SubMarker] = [
            SubMarker(notation: "1"),
            SubMarker(notation: "2"),
            SubMarker(notation: "3"),
            SubMarker(notation: "4")
        ],
        publicCards: [Card] = [],
        myCards: [Card] = []
    ) {
        self.players = players
        self.edition = edition
        self.subMarkerTypes = subMarkerTypes
        self.publicCards = publicCards
        self.myCards = myCards
    }
    
    // MARK: - GET
//    func getPlayers() -> [Player] {
//        return players.sorted { $0.id < $1.id }
//    }
    
//    func getPlayersWithoutSolution() -> [Player] {
//        return players
//            .filter { !($0 is Solution) }
//            .sorted { $0.id < $1.id }
//    }
    
    func getPlayerCount() -> Int {
        return players.count
    }
    
//    func getPlayersCountWithoutSolution() -> Int {
//        return players.filter { !($0 is Solution) }.count
//    }
    
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
    
    func getPublicCards() -> [Card] {
        return publicCards
    }
    
    func getMyCards() -> [Card] {
        return myCards
    }
    
    // MARK: - SET
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
        
        var player: Player
        
        switch type {
        case .user:
            player = User(name: name)
        case .other:
            player = Other(name: name)
        }
        
        players.append(player)
    }
    
    func addPublicCard(_ card: Card) throws {
        guard !publicCards.contains(card) else {
            throw SettingError.alreadySelectedCard
        }
        
        publicCards.append(card)
    }
    
    func addMyCard(_ card: Card) throws {
        guard !myCards.contains(card) else {
            throw SettingError.alreadySelectedCard
        }
        
        myCards.append(card)
    }
    
    func removeAllPlayer() {
        players.removeAll()
    }
    
    func removeAllPublicCards() {
        publicCards.removeAll()
    }

    func removeAllMyCards() {
        myCards.removeAll()
    }
}

extension Setting {
    private func isValidSubMarkerNotation(_ notation: String) -> Bool {
        return !notation.isEmpty && notation.count <= 2
    }
    
    private func isDuplicatePlayer(id: Int, name: String) -> Bool {
//        for player in players {
//            if player.id == id || player.name == name {
//                return true
//            }
//        }
        return false
    }
}
