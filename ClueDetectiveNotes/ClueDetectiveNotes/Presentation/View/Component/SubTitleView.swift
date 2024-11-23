//
//  SubTitleView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 10/27/24.
//

import SwiftUI

struct SubTitleView: View {
    private let subTitle: String
    
    init(_ subTitle: String) {
        self.subTitle = subTitle
    }
    
    var body: some View {
        HStack {
            Text(subTitle)
                .font(.title3)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SubTitleView("부제목입니다.")
}
