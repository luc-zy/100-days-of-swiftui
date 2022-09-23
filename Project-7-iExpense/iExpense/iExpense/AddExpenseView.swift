//
//  AddExpenseView.swift
//  iExpense
//
//  Created by 张洋 on 2022/9/21.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @State var inputName = ""
    @State var inputType = "Personal"
    @State var inputAmount = 0.0
    
    @ObservedObject var expenses: Expenses
    
    let types = ["Personal", "Bussiness"]
    var body: some View {
        NavigationView {
            Form{
                TextField("Name", text: $inputName)
                Picker("Type", selection: $inputType) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
                TextField("Amount", value: $inputAmount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }.navigationTitle("AddExpense")
            .toolbar {
                Button {
                    expenses.items.append(ExpenseItem(name: inputName, type: inputType, amount: inputAmount))
                    dismiss()
                } label: {
                    Text("Add")
                }
            }
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenses: Expenses())
    }
}
