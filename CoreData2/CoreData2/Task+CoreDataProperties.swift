//
//  Task+CoreDataProperties.swift
//  CoreData2
//
//  Created by Vinícius Flores Ribeiro on 29/04/22.
//
//

import Foundation
import CoreData
import UIKit

extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var completed: Bool
    @NSManaged public var createdAT: Date?
    @NSManaged public var difficulty: Int64
    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var title: String?

}

extension Task : Identifiable {

}
