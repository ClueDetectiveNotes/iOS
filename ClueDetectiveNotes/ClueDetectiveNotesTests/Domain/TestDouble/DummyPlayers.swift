//
//  DummyPlayers.swift
//  ClueDetectiveNotesTests
//
//  Created by Dasan & Mary on 2024/04/13.
//

@testable import ClueDetectiveNotes

struct DummyPlayers {
    static let players: [any Player] = [
        Other(id: 1, name: "코코"),
        Other(id: 2, name: "다산"),
        Other(id: 3, name: "메리"),
        Other(id: 4, name: "야곰")
    ]
}
