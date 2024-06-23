//
//  ControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

import SwiftUI

struct ControlBarView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let controlBarInteractor: ControlBarInteractor
    
    init(
        sheetStore: SheetStore
    ) {
        self.sheetStore = sheetStore
        self.controlBarInteractor = ControlBarInteractor(sheetStore: sheetStore)
    }
    
    var body: some View {
        HStack(spacing: 30) {
            
            // Undo
            Button(
                action: {
                    controlBarInteractor.clickUndo()
                },
                label: {
                    Image(systemName: "arrow.uturn.left")
                }
            )
            
            // Rndo
            Button(
                action: {
                    controlBarInteractor.clickRedo()
                },
                label: {
                    Image(systemName: "arrow.uturn.right")
                }
            )
            
            // Clear
            Button(
                action: {
                    controlBarInteractor.clickClearButton()
                },
                label: {
                    Image(systemName: "eraser")
                }
            )
            
            // Cancel
            Button(
                action: {
                    controlBarInteractor.clickCancelButton()
                },
                label: {
                    Image(systemName: "square.dashed")
                }
            )
        }
        .padding(10)
    }
}

#Preview {
    ControlBarView(sheetStore: SheetStore())
}
