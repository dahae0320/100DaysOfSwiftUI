//
//  ControllingAnimationStacksView.swift
//  Animations
//
//  Created by Da Hae Lee on 12/4/23.
//

import SwiftUI

struct ControllingAnimationStacksView: View {
    @State private var enabled = false
    
    var body: some View {
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(.default, value: enabled)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
    }
}

#Preview {
    ControllingAnimationStacksView()
}
