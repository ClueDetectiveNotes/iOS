//
//  SizePreferenceKey.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/5/24.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
