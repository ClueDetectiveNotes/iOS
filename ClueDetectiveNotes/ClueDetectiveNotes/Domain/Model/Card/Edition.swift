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
//                    .init(name: "SCARLET", type: .suspect),
//                    .init(name: "MUSTARD", type: .suspect),
//                    .init(name: "WHITE", type: .suspect),
//                    .init(name: "GREEN", type: .suspect),
//                    .init(name: "PEACOCK", type: .suspect),
//                    .init(name: "PLUM", type: .suspect)
                    .init(name: "스칼렛", type: .suspect),
                    .init(name: "머스타드", type: .suspect),
                    .init(name: "화이트", type: .suspect),
                    .init(name: "그린", type: .suspect),
                    .init(name: "피콕", type: .suspect),
                    .init(name: "플럼", type: .suspect)
                ],
                weapon: [
//                    .init(name: "CANDLESTICK", type: .weapon),
//                    .init(name: "KNIFE", type: .weapon),
//                    .init(name: "LEAD_PIPE", type: .weapon),
//                    .init(name: "REVOLVER", type: .weapon),
//                    .init(name: "ROPE", type: .weapon),
//                    .init(name: "WRENCH", type: .weapon),
                    .init(name: "촛대", type: .weapon),
                    .init(name: "단검", type: .weapon),
                    .init(name: "파이프", type: .weapon),
                    .init(name: "권총", type: .weapon),
                    .init(name: "밧줄", type: .weapon),
                    .init(name: "렌치", type: .weapon),
                ],
                room: [
//                    .init(name: "BATHROOM", type: .room),
//                    .init(name: "STUDY", type: .room),
//                    .init(name: "GAME_ROOM", type: .room),
//                    .init(name: "GARAGE", type: .room),
//                    .init(name: "BEDROOM", type: .room),
//                    .init(name: "LIVING_ROOM", type: .room),
//                    .init(name: "KITCHEN", type: .room),
//                    .init(name: "YARD", type: .room),
//                    .init(name: "DINING_ROOM", type: .room),
                    .init(name: "욕실", type: .room),
                    .init(name: "서재", type: .room),
                    .init(name: "게임룸", type: .room),
                    .init(name: "차고", type: .room),
                    .init(name: "침실", type: .room),
                    .init(name: "거실", type: .room),
                    .init(name: "부엌", type: .room),
                    .init(name: "마당", type: .room),
                    .init(name: "식당", type: .room),
                ]
            )
        }
    }
}
