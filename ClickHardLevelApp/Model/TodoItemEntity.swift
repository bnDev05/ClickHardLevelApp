//
//  TodoItemEntity.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI
import CoreData

// MARK: - Core Data Model (NSManagedObject)
@objc(TodoItem)
public class TodoItemEntity: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var todoDescription: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var priority: Int16
    @NSManaged public var dueDate: Date?
    @NSManaged public var createdAt: Date
    @NSManaged public var category: String?
}

extension TodoItemEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItemEntity> {
        return NSFetchRequest<TodoItemEntity>(entityName: "TodoItem")
    }
}
