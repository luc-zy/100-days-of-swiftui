//
//  Person.swift
//  Friends
//
//  Created by zhangyang on 26/6/2024.
//

import Foundation

struct Person: Codable, Identifiable, Equatable, Hashable{
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
