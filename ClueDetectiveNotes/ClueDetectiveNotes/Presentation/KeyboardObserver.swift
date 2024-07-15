//
//  KeyboardObserver.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 7/3/24.
//

import SwiftUI

final class KeyboardObserver: ObservableObject {
    @Published private(set) var isKeyboardVisible: Bool = false
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyBoardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyBoardWillShow(notification: Notification) {
        if let _ = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            isKeyboardVisible = true
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        isKeyboardVisible = false
    }
}
