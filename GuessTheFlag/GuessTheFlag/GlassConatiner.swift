//
//  GlassConatiner.swift
//  GuessTheFlag
//
//  Created by Da Hae Lee on 10/18/23.
//

import SwiftUI

struct GlassConatiner<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(spacing: 15) {
            content
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
}
