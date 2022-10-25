//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by 张洋 on 2022/10/17.
//

import Foundation

extension Bundle {
    //注意使用范型
    func decode<T: Decodable>(_ file: String) -> T {
        //1. 读取URL
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        //2. 构建Data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        //3. 使用JsonDecoder反序列化Data
        let decoder: JSONDecoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let loaded = try? decoder.decode(T.self, from: data) else{
            fatalError("Failed to decode \(file) from bundle")
        }
        return loaded
    }
}
