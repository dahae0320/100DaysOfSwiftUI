//
//  ContentView.swift
//  BetterRest
//
//  Created by Da Hae Lee on 10/29/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultSleepTime
    @State private var sleepAmout = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultSleepTime: Date {
        let component = DateComponents(hour: 7, minute: 0)
        return Calendar.current.date(from: component) ?? .now
    }
    
    var calculateBedtime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Int64(hour+minute), estimatedSleep: sleepAmout, coffee: Int64(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }
                
                Section("Desired amout of sleep") {
                    Stepper("\(sleepAmout.formatted()) hours", value: $sleepAmout, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Picker("Number of cups", selection: $coffeeAmount) {
                        ForEach(0..<21) { number in
                            Text("^[\(number) cup](inflect: true)")
                        }
                    }
                }
                
                Section {
                    HStack {
                        Spacer()
                        VStack (spacing: 30) {
                            Text("Your bedtime is...")
                                .font(.subheadline)
                            Text(calculateBedtime)
                                .font(.largeTitle)
                                .bold()
                        }
                        Spacer()
                    }
                    .padding(20)
                }
            }
            .navigationTitle("BetterRest")
        }
    }
}

#Preview {
    ContentView()
}
