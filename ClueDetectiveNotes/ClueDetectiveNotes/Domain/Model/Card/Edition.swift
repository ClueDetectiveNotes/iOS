//
//  Edition.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 2024/04/16.
//

enum Edition {
    case classic
    
    var cards: Cards {
        switch self {
        case .classic:
            return Cards(
                suspects: [
                    .init(name: "SCARLET", type: .suspect),
                    .init(name: "MUSTARD", type: .suspect),
                    .init(name: "WHITE", type: .suspect),
                    .init(name: "GREEN", type: .suspect),
                    .init(name: "PEACOCK", type: .suspect),
                    .init(name: "PLUM", type: .suspect)
                ],
                weapon: [
                    .init(name: "CANDLESTICK", type: .weapon),
                    .init(name: "KNIFE", type: .weapon),
                    .init(name: "LEAD_PIPE", type: .weapon),
                    .init(name: "REVOLVER", type: .weapon),
                    .init(name: "ROPE", type: .weapon),
                    .init(name: "WRENCH", type: .weapon),
                ],
                room: [
                    .init(name: "BATHROOM", type: .room),
                    .init(name: "STUDY", type: .room),
                    .init(name: "GAME_ROOM", type: .room),
                    .init(name: "GARAGE", type: .room),
                    .init(name: "BEDROOM", type: .room),
                    .init(name: "LIVING_ROOM", type: .room),
                    .init(name: "KITCHEN", type: .room),
                    .init(name: "YARD", type: .room),
                    .init(name: "DINING_ROOM", type: .room),
                ]
            )
        }
    }
}
