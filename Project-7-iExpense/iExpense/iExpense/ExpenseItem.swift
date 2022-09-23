//
//  ExpenseItem.swift
//  iExpense
//
//  Created by 张洋 on 2022/9/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
