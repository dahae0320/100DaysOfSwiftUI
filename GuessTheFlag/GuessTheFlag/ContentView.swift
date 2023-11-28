//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Da Hae Lee on 10/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var showingRestart = false
    @State private var userScore = 0
    @State private var quizCount = 1
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            alertMessage = "Your score is \(userScore+1)."
            userScore += 1
        } else {
            scoreTitle = "Wrong..."
            alertMessage = "That’s the flag of \(countries[number])."
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        quizCount += 1
        if quizCount > 8 {
            showingRestart = true
        }
    }
    
    func reset() {
        askQuestion()
        userScore = 0
        quizCount = 1
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 500)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                GlassConatiner {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                    }
                }
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .promientTitle(with: "progress: \(quizCount)/8")
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("continue", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
        .alert("Result", isPresented: $showingRestart) {
            Button("restart", action: reset)
        } message: {
            VStack {
                Text("Your total score is \(userScore)/8. You can restart the quiz.")
            }
        }
    }
}

struct FlagImage: View {
    var countryName = ""
    
    var body: some View {
        Image(countryName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
    
    init(countryName: String) {
        self.countryName = countryName
    }
}

#Preview {
    ContentView()
}


