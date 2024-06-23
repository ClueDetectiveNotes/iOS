//
//  Player.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/13.
//

protocol Player: Hashable {
    var id: Int { get set }
    var name: String { get set }
}

struct User: Player {
    var id: Int
    var name: String
}

struct Other: Player {
    var id: Int
    var name: String
}

struct Solution: Player {
    var id: Int
    var name: String
}

enum PlayerType {
    case user
    case other
    case solution
}
