#Your challenge
You need to build an app that handles unit conversions: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.

Which units you choose are down to you, but you could choose one of these:

Temperature conversion: users choose Celsius, Fahrenheit, or Kelvin.
Length conversion: users choose meters, kilometers, feet, yards, or miles.
Time conversion: users choose seconds, minutes, hours, or days.
Volume conversion: users choose milliliters, liters, cups, pints, or gallons.
If you were going for length conversion you might have:

A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
A text field where users enter a number.
A text view showing the result of the conversion.
So, if you chose meters for source unit and feet for output unit, then entered 10, you’d see 32.81 as the output.

#Tips
You already know everything you need to complete this project, but if you’re hitting problems then I have some tips that might help.

First, all our unit conversions are simple mathematics, but you shouldn’t try to write conversions to go from every source unit to very other unit. A better idea is to convert the user’s input to a single base unit, then convert from there to the target unit.

So, rather than writing code to convert from liters to milliliters, and from liters to cups, and from liters to pints, and so on, a better idea is to convert the user’s input into milliliters (the lowest common denominator), then convert from there to whatever output unit they want.

Even though you can absolutely complete this project using simple arithmetic, you might be interested to know that Apple does give us dedicated functionality for doing unit conversion – see my article How to convert units using Unit and Measurement if you’re curious. However, I should reiterate that it is not required to complete this project: you can convert from liters to pints (for example) just by multiplying the input by 2.11338.

As we have three user values here – their input number, their input unit, and their output unit – you need to have three @State properties to store them all. You’ll need a textfield plus two segmented controls, plus a text view to show your output, and that’s about it.

So, go ahead and get started now. Don’t worry if you need to refer back to the WeSplit project – that’s perfectly normal, and is all part of the learning process.

Good luck! You can do this. And once you’re done, tell other people: you’ve built another SwiftUI app, and this one was entirely designed by you.

You should be proud of what you’ve accomplished.
