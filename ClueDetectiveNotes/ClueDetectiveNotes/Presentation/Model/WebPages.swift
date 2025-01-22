//
//  WebPages.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 1/20/25.
//

enum WebPages {
    case help
    
    var url: String {
        switch self {
        case .help:
            return "https://cyan-satin-9e6.notion.site/181cb7d0177180358bfeca9764fb2e42?pvs=4"
        }
    }
}
