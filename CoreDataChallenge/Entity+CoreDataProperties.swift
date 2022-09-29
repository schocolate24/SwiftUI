//
//  Entity+CoreDataProperties.swift
//  CoreDataChallenge
//
//  Created by 中木翔子 on 2022/08/24.
//
//

import Foundation
import CoreData


extension ExampleData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExampleData> {
        return NSFetchRequest<ExampleData>(entityName: "Entity")
    }

    @NSManaged public var friend: String?
    @NSManaged public var user: String?

}

extension ExampleData : Identifiable {

}
