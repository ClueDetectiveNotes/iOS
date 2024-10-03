//
//  ControlBarStore.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 9/17/24.
//

import Foundation

final class ControlBarStore: ObservableObject {
    @Published private(set) var controlBar: PresentationControlBar
    
    init(
        controlBar: PresentationControlBar = ConvertManager.getImmutableControlBar(mutableSubMarkerType: SubMarkerType.shared)
    ) {
        self.controlBar = controlBar
    }
    
    func overwriteControlBar(_ newControlBar: PresentationControlBar) {
        controlBar = newControlBar
    }
}
