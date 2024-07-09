//
//  SafeAreaInsetsKey.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/9/24.
//

import SwiftUI

public struct SafeAreaInsetsKey: EnvironmentKey {
    public static var defaultValue: EdgeInsets {
        (UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero).insets
    }
}

extension EnvironmentValues {
    public var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

extension UIEdgeInsets {
    public var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
