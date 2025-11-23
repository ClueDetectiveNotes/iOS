//
//  Edition.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/16.
//

enum Edition {
    case classic
    
    var deck: Deck {
        switch self {
        case .classic:
            return Deck(
                suspects: [
                    .init(rawName: "SCARLET", name: "SCARLET", type: .suspect),
                    .init(rawName: "MUSTARD",name: "MUSTARD", type: .suspect),
                    .init(rawName: "WHITE",name: "WHITE", type: .suspect),
                    .init(rawName: "GREEN",name: "GREEN", type: .suspect),
                    .init(rawName: "PEACOCK",name: "PEACOCK", type: .suspect),
                    .init(rawName: "PLUM",name: "PLUM", type: .suspect)
                ],
                weapons: [
                    .init(rawName: "CANDLESTICK",name: "CANDLESTICK", type: .weapon),
                    .init(rawName: "KNIFE",name: "KNIFE", type: .weapon),
                    .init(rawName: "LEAD_PIPE",name: "LEAD_PIPE", type: .weapon),
                    .init(rawName: "REVOLVER",name: "REVOLVER", type: .weapon),
                    .init(rawName: "ROPE",name: "ROPE", type: .weapon),
                    .init(rawName: "WRENCH",name: "WRENCH", type: .weapon),
                ],
                rooms: [
                    .init(rawName: "BATHROOM",name: "BATHROOM", type: .room),
                    .init(rawName: "STUDY",name: "STUDY", type: .room),
                    .init(rawName: "GAME_ROOM",name: "GAME_ROOM", type: .room),
                    .init(rawName: "GARAGE",name: "GARAGE", type: .room),
                    .init(rawName: "BEDROOM",name: "BEDROOM", type: .room),
                    .init(rawName: "LIVING_ROOM",name: "LIVING_ROOM", type: .room),
                    .init(rawName: "KITCHEN",name: "KITCHEN", type: .room),
                    .init(rawName: "YARD",name: "YARD", type: .room),
                    .init(rawName: "DINING_ROOM",name: "DINING_ROOM", type: .room),
                ]
            )
        }
    }
}
