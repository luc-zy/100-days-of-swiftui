//
//  SecondView.swift
//  StateTest
//
//  Created by 张洋 on 2022/7/31.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var name: String
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }.onDelete(perform: removeRows)
                }
                Button("Add Number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                    print(numbers)
                }
                Spacer()
                Button("Dismiss") {
                    dismiss()
                }
            }.toolbar {
                EditButton()
            }
        }
    }
    
    func removeRows(at offsets: IndexSet) {
        for i in offsets{
            print(i)
        }
        numbers.remove(atOffsets: offsets)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(name: "Test")
    }
}
