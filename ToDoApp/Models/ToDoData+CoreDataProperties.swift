//
//  ToDoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by Kang on 2023/10/03.
//
//

import UIKit
import CoreData


extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var color: Int64
    @NSManaged public var date: Date?
    @NSManaged public var memoText: String?

}

extension ToDoData : Identifiable {

}
