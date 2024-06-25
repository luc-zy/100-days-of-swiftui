//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by zhangyang on 24/6/2024.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmMessage = ""
    @State private var showingConfirm = false
    var body: some View {
        ScrollView {
            VStack(content: {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }.frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button(action: {
                    Task {
                        await placeOrder()
                    }
                }, label: {
                    Text("Place order")
                }).padding()
            })
        }.navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .scrollBounceBehavior(.basedOnSize)
            .alert("Thank you!", isPresented: $showingConfirm) {
                Button("OK") { }
            } message: {
                Text(confirmMessage)
            }

    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else { return }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            confirmMessage = "Your order for \(decoded.quantity)x \(Order.types[decoded.type].lowercased()) is on its way!"
            showingConfirm = true
        }catch{
            print("Checkout faild: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
