//
//  TransitionView.swift
//  Animations
//
//  Created by Da Hae Lee on 12/4/23.
//

import SwiftUI

struct TransitionView: View {
    @State private var isShowingRed = false
    @State private var isShowingGreen = false
    
    var body: some View {
        VStack {
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        isShowingRed.toggle()
                    }
                }
                
                if isShowingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
            ZStack {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                
                if isShowingGreen {
                    Rectangle()
                        .fill(.green)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
            .onTapGesture {
                withAnimation {
                    isShowingGreen.toggle()
                }
            }
        }
    }
}

#Preview {
    TransitionView()
}
