//
//  ControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

import SwiftUI

struct ControlBarView: View {
    @ObservedObject private var sheetStore: SheetStore
    private let controlBarInteractor: ControlBarInterator
    
    init(
        sheetStore: SheetStore
    ) {
        self.sheetStore = sheetStore
        self.controlBarInteractor = ControlBarInterator(sheetStore: sheetStore)
    }
    
    var body: some View {
        HStack(spacing: 30) {
            Button(
                action: {
                    controlBarInteractor.clickUndo()
                },
                label: {
                    Image(systemName: "arrow.uturn.left") // Undo
                }
            )
            
            Button(
                action: {
                    controlBarInteractor.clickRedo()
                },
                label: {
                    Image(systemName: "arrow.uturn.right") // Rndo
                }
            )
            
            Button(
                action: {
                    //controlBarInteractor
                },
                label: {
                    Image(systemName: "eraser") // Clear
                }
            )
            
            Button(
                action: {
                    //controlBarInteractor
                },
                label: {
                    Image(systemName: "square.dashed") // Cancel
                }
            )
        }
        .padding(10)
    }
}

#Preview {
    ControlBarView(sheetStore: SheetStore())
}
