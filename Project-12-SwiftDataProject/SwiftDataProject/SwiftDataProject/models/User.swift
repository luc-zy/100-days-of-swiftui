//
//  User.swift
//  SwiftDataProject
//
//  Created by zhangyang on 14/6/2024.
//

import Foundation
import SwiftData

@Model
class User{
    var name: String  = "None"
    var city: String  = "Unknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade)
    var jobs: [Job]? = [Job]()
    var unwrapJobs: [Job] {jobs ?? []}
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
