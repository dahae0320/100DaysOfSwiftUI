//
//  GestureAnimationView.swift
//  Animations
//
//  Created by Da Hae Lee on 12/4/23.
//

import SwiftUI

struct GestureAnimationView: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        VStack {
            LinearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            dragAmount = .zero
                        }
                )
                .animation(.bouncy, value: dragAmount)
            
            GestureAnimationView2()
        }
    }
}

struct GestureAnimationView2: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

#Preview {
    GestureAnimationView()
}
