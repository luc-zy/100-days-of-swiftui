//
//  PersonStore.swift
//  Friends
//
//  Created by zhangyang on 26/6/2024.
//

import Foundation
import SwiftUI

@Observable
class PersonStore{
    static let shared = PersonStore()
    
    var people: [Person]?
    var path: NavigationPath = NavigationPath()
    
    func clearData() {
        self.people = nil
    }
    
    func loadData() async {
        if people != nil{
            return
        }
        var request = URLRequest(url: URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            print("data downloaded from url")
            let decoder: JSONDecoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            people = try decoder.decode([Person].self, from: data)
        }catch{
            print("Error to fetch data, \(String(describing: error))")
        }
    }
    
    func isPersonActive(id: String) -> Bool {
        if let people = people {
            return people.first { person in
                person.id == id
            }?.isActive ?? false
        }
        return false
    }
}
