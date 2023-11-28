//
//  MesurementUnitView.swift
//  UnitConversion
//
//  Created by Da Hae Lee on 10/10/23.
//

import SwiftUI

struct MesurementUnitView: View {
    @State private var inputUnit = UnitTemperature.celsius
    @State private var inputNumber = 0.0
    @State private var outputUnit = UnitTemperature.fahrenheit
    
    var inputConverse: Double {
        switch inputUnit {
        case .celsius:
            return inputNumber
        case .fahrenheit:
            return (inputNumber - 32) * 5 / 9
        case .kelvin:
            return inputNumber - 273.15
        default:
            return inputNumber
        }
    }
    
    var conversionResult: Double {
        switch outputUnit {
        case .celsius:
            return inputConverse
        case .fahrenheit:
            return inputConverse * (9/5) + 32
        case .kelvin:
            return inputConverse + 273.15
        default:
            return inputConverse
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select Your Input Unit", selection: $inputUnit) {
                        ForEach(TemperatureUnit.allCases, id:\.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    TextField("What's yours?", value: $inputNumber, format: .number)
                } header: {
                    Text("Input Temperature")
                }
                
                Section {
                    Picker("Select Your Output Unit", selection: $outputUnit) {
                        ForEach(TemperatureUnit.allCases, id:\.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Text("\(conversionResult.formatted())")
                } header: {
                    Text("Conversion Result")
                }
            }
            .navigationTitle("Temperature")
        }
    }
}

#Preview {
    MesurementUnitView()
}
