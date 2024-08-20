//
//  Task+CoreDataProperties.swift
//  TODO List
//
//  Created by Mustafa Jawad on 5/8/2024.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var isComplete: Bool
    @NSManaged public var group: Group?

}

extension Task : Identifiable {

}
