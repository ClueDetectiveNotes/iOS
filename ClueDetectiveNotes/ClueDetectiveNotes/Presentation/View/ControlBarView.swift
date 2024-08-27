//
//  ControlBarView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/17/24.
//

import SwiftUI

struct ControlBarView: View {
    @EnvironmentObject private var geometryStore: GeometryStore
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
            
            // Redo
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
            
            Spacer()
            
            Button(
                action: {
                    // 화면 가리기
                    controlBarInteractor.clickVisibleButton()
                },
                label: {
                    Image(systemName: sheetStore.isVisibleScreen ? "eye" : "eye.slash")
                }
            )
            
            // Setting
            Button(
                action: {
                    // 세팅 화면
                },
                label: {
                    Image(systemName: "ellipsis")
                }
            )
        }
        .padding(10)
        .padding(.horizontal, 20)
        .frame(height: geometryStore.controlBarHeight)
    }
}

#Preview {
    ControlBarView(sheetStore: SheetStore())
        .environmentObject(GeometryStore())
}
