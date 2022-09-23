//
//  Expense.swift
//  iExpense
//
//  Created by 张洋 on 2022/9/21.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "Items"){
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: data){
                items = decoded
                return
            }
        }
        items = []
    }
}
