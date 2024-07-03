//
//  Person.swift
//  Friends
//
//  Created by zhangyang on 26/6/2024.
//

import Foundation

struct PersonDto: Codable, Identifiable, Equatable, Hashable{
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var address: String
    var registered: Date
    var company: String
    var email: String
    var about: String
    var tags: [String]
    var friends: [FriendDto]
}
