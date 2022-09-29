//
//  FileManager.swift
//  BucketList
//
//  Created by 中木翔子 on 2022/09/28.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
}
