//
//  User.swift
//  CupcakeCorner
//
//  Created by zhangyang on 22/6/2024.
//

import Foundation

@Observable
class User: Codable{
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name: String = "zhangyang"
}
