//
//  ControlBarStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/17/24.
//

import Foundation

final class ControlBarStore: ObservableObject {
    @Published private(set) var controlBar: PresentationControlBar
    @Published var showOptionView: Bool
    
    init(
        controlBar: PresentationControlBar = ConvertManager.getImmutableControlBar(mutableSubMarkerType: SubMarkerType.shared),
        showOptionView: Bool = false
    ) {
        self.controlBar = controlBar
        self.showOptionView = showOptionView
    }
    
    func overwriteControlBar(_ newControlBar: PresentationControlBar) {
        controlBar = newControlBar
    }
    
    func setshowOptionView(_ value: Bool) {
        showOptionView = value
    }
}
