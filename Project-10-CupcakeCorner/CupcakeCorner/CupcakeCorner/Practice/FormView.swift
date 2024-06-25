//
//  FormView.swift
//  CupcakeCorner
//
//  Created by zhangyang on 22/6/2024.
//

import SwiftUI

struct FormView: View {
    @State private var username = ""
    @State private var email = ""
    
    @State private var counter = 0
    
    var disableForm: Bool {
        username.isEmpty || email.isEmpty
    }

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
                Button(action: {
                    counter += 1
                }, label: {
                    Text("Tap \(counter)")
                }).sensoryFeedback(.error, trigger: counter)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }.disabled(disableForm)
            }
            Button(action: {
                let encode = try! JSONEncoder().encode(User())
                print(String(data: encode, encoding: .utf8) ?? "")
            }, label: {
                Text("Encod User")
            })
        }
    }
}

#Preview {
    FormView()
}
