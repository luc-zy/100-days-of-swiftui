//
//  PathStore.swift
//  Navigation
//
//  Created by zhangyang on 20/6/2024.
//

import Foundation
import SwiftUI

@Observable
class PathStore {
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    var path: NavigationPath{
        didSet {
            save()
        }
    }
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        do{
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        }catch {
            print("Failed to save NavigationPath")
        }
    }
}
