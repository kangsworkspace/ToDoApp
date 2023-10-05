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

    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = self.date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}

extension ToDoData : Identifiable {

}
