//
//  FooterView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/23/24.
//

import SwiftUI

struct FooterView: View {
    let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .foregroundStyle(Color("darkgray1"))
            .padding()
    }
}

#Preview {
    FooterView(text: "테스트")
}
