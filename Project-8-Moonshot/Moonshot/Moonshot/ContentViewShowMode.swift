//
//  ContentViewShowMode.swift
//  Moonshot
//
//  Created by 张洋 on 2022/10/25.
//

import Foundation

enum ContentViewShowMode: String, CaseIterable, Identifiable{
    case list, grid
    var id: Self {self}
}
