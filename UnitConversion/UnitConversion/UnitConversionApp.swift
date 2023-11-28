// MARK: challenge
/**
 You need to build an app that handles unit conversions:
 users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
 
 Which units you choose are down to you, but you could choose one of these:
 - Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
 - Length conversion: users choose meters, kilometers, feet, yards, or miles.
 - Time conversion: users choose seconds, minutes, hours, or days.
 - Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
 
 If you were going for length conversion you might have:
 1. A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
 2. A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
 3. A text field where users enter a number.
 4. A text view showing the result of the conversion.
 
 So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.
 */

import SwiftUI

@main
struct UnitConversionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
