//
//  ColorSchemeObserver.swift
//  ClueDetectiveNotes
//
//  Created by Yena on 10/27/24.
//

import SwiftUI

final class ColorSchemeObserver: ObservableObject {
    @Published private(set) var colorScheme: ColorScheme = .light
    
    init() {
        updateColorScheme()
        
        // 앱이 포그라운드로 돌아올 때
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(updateColorScheme),
//            name: UIScene.willEnterForegroundNotification,
//            object: nil
//        )
        
        // 앱이 활성화 되었을 때
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateColorScheme),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func updateColorScheme() {
        // 현재 시스템 색상 모드 확인
        if UITraitCollection.current.userInterfaceStyle == .dark {
            colorScheme = .dark
        } else {
            colorScheme = .light
        }
        print("호잉")
    }
}
