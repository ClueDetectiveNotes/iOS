//
//  ScreenMode.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/31/24.
//

import SwiftUI

enum ScreenMode: String, CaseIterable, Identifiable {
    case light, dark, system
    
    var id: Self { self }
    
    func getColorScheme() -> ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
}
