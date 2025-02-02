//
//  EdgeBorder.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 1/22/25.
//

import SwiftUI

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top:
                return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom:
                return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading:
                return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing:
                return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { partialResult, nextPath in
            partialResult.addPath(nextPath)
        }
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color ) -> some View {
        overlay(
            EdgeBorder(width: width, edges: edges)
                .foregroundColor(color)
        )
    }
}
