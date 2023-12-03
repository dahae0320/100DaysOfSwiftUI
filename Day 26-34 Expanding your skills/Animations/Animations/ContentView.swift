//
//  ContentView.swift
//  Animations
//
//  Created by Da Hae Lee on 12/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    @State private var animationAmount2 = 1.0
    @State private var animationAmount3 = 0.0

    
    var body: some View {
        VStack {
            Group {
                Stepper("Scale amount", value: $animationAmount.animation(
                    .easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
                ), in: 1...10)
                
                Spacer()
                
                Button("Tap Me 1") {
                    animationAmount += 1
                }
                .padding(40)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .scaleEffect(animationAmount)
            }
            
            Group {
                Button("Tap Me 2") {
                    withAnimation(.spring(duration: 1, bounce: 0.5)) {
                        animationAmount2 += 360
                    }
                }
                .padding(50)
                .background(.green)
                .foregroundStyle(.white)
                .clipShape(.circle)
                .rotation3DEffect(.degrees(animationAmount2), axis: (x: 0, y: 1, z: 0))
            }
            
            /** implicit animation and customizing */
            Group {
                Button("Tap Me 3") { }
                    .padding(50)
                    .background(.red)
                    .foregroundStyle(.white)
                    .clipShape(.circle)
                    .overlay {
                        Circle()
                            .stroke(.red)
                            .scaleEffect(animationAmount3)
                            .opacity(2 - animationAmount3)
                            .animation(
                                .easeInOut(duration: 1)
                                .repeatForever(autoreverses: false),
                                value: animationAmount3)
                    }
            }
        }
        .onAppear {
            animationAmount3 = 2
        }
    }
}

#Preview {
    ContentView()
}
