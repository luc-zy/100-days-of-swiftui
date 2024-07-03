//
//  Friend.swift
//  Friends
//
//  Created by zhangyang on 26/6/2024.
//

import Foundation

struct FriendDto: Codable, Identifiable, Equatable, Hashable{
    var id: String
    var name: String
}
