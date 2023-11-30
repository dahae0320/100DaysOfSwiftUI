//
//  ContentView.swift
//  BrainTrainingRPS
//
//  Created by Da Hae Lee on 10/19/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Choose correctly!")
                .font(.largeTitle.bold())
            Text("computer pick 'RPS'")
            Text("You have to 'win/lose'")
            HStack {
                Button {
                    // 횟수 증가
                } label: {
                    Text("Rock")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
