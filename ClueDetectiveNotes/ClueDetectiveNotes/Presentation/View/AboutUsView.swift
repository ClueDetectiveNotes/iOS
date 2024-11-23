//
//  AboutUsView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/23/24.
//

import SwiftUI

struct AboutUsView: View {
    var body: some View {
        VStack {
            TitleView(
                title: "About Us",
                description: ""
            )
            
            ProfileView(emoji: "👻", name: "Qoqo", secondName: "코코", skill: "AOS")
            
            ProfileView(emoji: "🐿️", name: "Mary", secondName: "메리", skill: "iOS")
            
            ProfileView(emoji: "🍄", name: "Dasan", secondName: "다산", skill: "iOS")
            
            Spacer()
            
            FooterView(text: "Thank you")
        }
        .background(Color(.systemGroupedBackground))
    }
}

private struct ProfileView: View {
    private let emoji: String
    private let name: String
    private let secondName: String
    private let skill: String
    
    @State private var isPressed: Bool = false
    
    init(
        emoji: String,
        name: String,
        secondName: String,
        skill: String
    ) {
        self.emoji = emoji
        self.name = name
        self.secondName = secondName
        self.skill = skill
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Spacer()
                
                Text(emoji)
                    .font(.title)
                
                Spacer()
            }
            
            Text(
                isPressed
                ? secondName
                : name
            )
            .font(.headline)
            .foregroundStyle(Color("black1"))
            
            Text(skill)
                .font(.subheadline)
                .foregroundStyle(Color("darkgray1"))
        }
        .padding(10)
        .background(Color("white1"))
        .clipShape(.rect(cornerRadius: 15))
        .padding(.horizontal)
        .padding(.vertical, 5)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged({ _ in
                    isPressed = true
                })
                .onEnded({ _ in
                    isPressed = false
                })
        )
    }
}
    
#Preview {
    AboutUsView()
}
