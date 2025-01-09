//
//  Language.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/31/24.
//

enum Language: String, CaseIterable, Identifiable {
    case korean, english
    
    var id: Self { self }
    
    var text: String {
        switch self {
        case .korean:
            return "한국어"
        case .english:
            return "English"
        }
    }
    
    var code: String {
        switch self {
        case .korean:
            return "KR"
        case .english:
            return "EN"
        }
    }
}
