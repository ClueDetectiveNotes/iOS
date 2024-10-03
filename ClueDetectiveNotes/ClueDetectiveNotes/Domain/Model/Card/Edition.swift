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
                    .init(rawName: "SCARLET", name: "스칼렛", type: .suspect),
                    .init(rawName: "MUSTARD",name: "머스타드", type: .suspect),
                    .init(rawName: "WHITE",name: "화이트", type: .suspect),
                    .init(rawName: "GREEN",name: "그린", type: .suspect),
                    .init(rawName: "PEACOCK",name: "피콕", type: .suspect),
                    .init(rawName: "PLUM",name: "플럼", type: .suspect)
                ],
                weapons: [
                    .init(rawName: "CANDLESTICK",name: "촛대", type: .weapon),
                    .init(rawName: "KNIFE",name: "단검", type: .weapon),
                    .init(rawName: "LEAD_PIPE",name: "파이프", type: .weapon),
                    .init(rawName: "REVOLVER",name: "권총", type: .weapon),
                    .init(rawName: "ROPE",name: "밧줄", type: .weapon),
                    .init(rawName: "WRENCH",name: "렌치", type: .weapon),
                ],
                rooms: [
                    .init(rawName: "BATHROOM",name: "욕실", type: .room),
                    .init(rawName: "STUDY",name: "서재", type: .room),
                    .init(rawName: "GAME_ROOM",name: "게임룸", type: .room),
                    .init(rawName: "GARAGE",name: "차고", type: .room),
                    .init(rawName: "BEDROOM",name: "침실", type: .room),
                    .init(rawName: "LIVING_ROOM",name: "거실", type: .room),
                    .init(rawName: "KITCHEN",name: "부엌", type: .room),
                    .init(rawName: "YARD",name: "마당", type: .room),
                    .init(rawName: "DINING_ROOM",name: "식당", type: .room),
                ]
            )
        }
    }
}
