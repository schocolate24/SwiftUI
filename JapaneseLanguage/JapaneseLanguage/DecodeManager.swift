//
//  DecodeManager.swift
//  Japanese
//
//  Created by 中木翔子 on 2022/09/12.
//

import Foundation

struct Japanese: Codable, Identifiable {
    let id: Int
    let letter: String
    let image: String
    let example: String
    let voice1: String
    let voice2: String
}

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loadedData
    }
}
