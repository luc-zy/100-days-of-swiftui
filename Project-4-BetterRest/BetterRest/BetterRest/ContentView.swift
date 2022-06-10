//
//  ContentView.swift
//  BetterRest
//
//  Created by 张洋 on 2022/5/30.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeUp
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    private var sleepTime: Date {
        calculateSleepTime()
    }
    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView{
            Form {
                var pickerAmont = Binding {
                    coffeeAmount - 1
                } set: {
                    coffeeAmount = $0 + 1
                }


            
                Text("Your ideal bedtime is \(sleepTime.formatted(date: .omitted, time: .shortened))").font(.headline)
                
                Section{
                    Text("When do you want to wake up?").font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
//                VStack(alignment: .leading, spacing: 0) {
//
//                }
                Section{
                    Text("Desire amount of sleep").font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    
                }
//                VStack(alignment: .leading, spacing: 0) {
//
//                }
                Section{
                    Text("Daily coffe intake").font(.headline)
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    Picker("Daily cofffe intake", selection: pickerAmont) {
                        ForEach(1..<21) { i in
                            Text(i == 1 ? "1 cup": "\(i) cups")
                        }
                    }.pickerStyle(.wheel)
                }
//                VStack(alignment: .leading, spacing: 0) {
//                    
//                }
                
            }.navigationTitle("Better Rest")
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK", role: .cancel) {
                    
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() {
        do{
            let model = try SleepCalculator(configuration: MLModelConfiguration())
            let dateCompnents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (dateCompnents.hour ?? 0) * 60 * 60
            let minite = (dateCompnents.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minite), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is ..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
    
    func calculateSleepTime() -> Date {
        do{
            let model = try SleepCalculator(configuration: MLModelConfiguration())
            let dateCompnents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (dateCompnents.hour ?? 0) * 60 * 60
            let minite = (dateCompnents.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minite), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
            return Date.now
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
