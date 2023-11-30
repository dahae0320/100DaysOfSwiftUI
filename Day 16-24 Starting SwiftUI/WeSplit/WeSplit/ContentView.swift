//
//  ContentView.swift
//  프로그램의 초기 사용자 인터페이스(UI)가 포함되어 있음.
//  이 프로젝트의 모든 작업을 수행할 곳입니다.
//
//  Created by Da Hae Lee on 10/6/23.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmout = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20

    var totalAmout: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmout * (tipSelection / 100.0)
        return checkAmout + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)    // 2..<100이므로 시작값 2를 더해줘야 한다.
        return totalAmout / peopleCount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amout",
                              value: $checkAmout,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id:\.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmout,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total Amout")
                        .foregroundStyle(tipPercentage == 0 ? .red : .secondary)
                }
                
                Section {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                } header: {
                    Text("Amout per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
