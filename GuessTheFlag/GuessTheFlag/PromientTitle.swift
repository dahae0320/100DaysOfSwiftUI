//
//  PromientTitle.swift
//  GuessTheFlag
//
//  Created by Da Hae Lee on 10/18/23.
//

import SwiftUI

struct PromientTitle: ViewModifier {
    let text: String
    
    func body(content: Content) -> some View {
        VStack {
            Text(text)
                .font(.largeTitle.bold())
                .foregroundStyle(.blue)
                .padding()
            content
        }
    }
}

extension View {
    func promientTitle(with text: String) -> some View {
        modifier(PromientTitle(text: text))
    }
}
