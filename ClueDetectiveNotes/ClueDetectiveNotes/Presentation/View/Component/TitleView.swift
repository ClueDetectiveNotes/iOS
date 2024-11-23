//
//  TitleView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/20/24.
//

import SwiftUI

struct TitleView: View {
    private let title: String
    private let description: String
    
    init(
        title: String,
        description: String
    ) {
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            
            if !description.isEmpty {
                Spacer()
                    .frame(height: 10)
                
                HStack {
                    Text(description)
                        .foregroundStyle(.gray)
                    Spacer()
                }
            }
        }
        .padding()
    }
}

#Preview {
    TitleView(
        title: "Title",
        description: "설명입니다."
    )
}
