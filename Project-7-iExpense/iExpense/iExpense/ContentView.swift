//
//  ContentView.swift
//  iExpense
//
//  Created by 张洋 on 2022/9/13.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private var personalItems: [ExpenseItem] {
        expenses.items.filter({$0.type == "Personal"})
    }
    
    private var bussinessItems: [ExpenseItem] {
        expenses.items.filter({$0.type == "Bussiness"})
    }
    
    var body: some View {
        NavigationView {
            List{
                Section("Personal") {
                    ForEach(personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type).font(.subheadline)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                    }.onDelete(perform: deletePersonalItems)
                }
            
                Section("Bussiness") {
                    ForEach(bussinessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text(item.type).font(.subheadline)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                    }.onDelete(perform: deleteBussinessItems)
                }
            }.navigationTitle("IExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }.sheet(isPresented: $showingAddExpense) {
                AddExpenseView(expenses: expenses)
            }
        }
    }
    
    func deletePersonalItems(indexSet: IndexSet) {
        indexSet.forEach({
            let id = personalItems[$0].id
            print(id)
            if let realIndex = expenses.items.firstIndex(where: {$0.id == id}){
                print(realIndex)
                expenses.items.remove(at: realIndex)
            }else{
                fatalError("无法删除")
            }
        })
    }
    
    func deleteBussinessItems(indexSet: IndexSet) {
        indexSet.forEach({
            let id = bussinessItems[$0].id
            if let realIndex = expenses.items.firstIndex(where: {$0.id == id}){
                expenses.items.remove(at: realIndex)
            }else{
                fatalError("无法删除")
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
