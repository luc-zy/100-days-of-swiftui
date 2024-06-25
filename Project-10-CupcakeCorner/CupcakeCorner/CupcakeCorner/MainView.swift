//
//  MainView.swift
//  CupcakeCorner
//
//  Created by zhangyang on 22/6/2024.
//

import SwiftUI

struct MainView: View {
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form(content: {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 2...20)
                }
                
                Section {
                    Toggle("Any sepcial requests?", isOn: $order.specialRequestEnabled)
                    if order.specialRequestEnabled {
                        Toggle("Add extra foresting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details"){
                        AddressView(order: order)
                    }
                }
            }).navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    MainView()
}
