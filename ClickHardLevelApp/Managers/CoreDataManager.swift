//
//  CoreDataManager.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import CoreData
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = PersistenceController.shared.container
    
    var context: NSManagedObjectContext  = PersistenceController.shared.container.viewContext
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
    
    // CRUD Operations
    func create(item: TodoItem) {
        let entity = TodoItemEntity(context: context)
        entity.id = item.id
        entity.title = item.title
        entity.todoDescription = item.todoDescription
        entity.isCompleted = item.isCompleted
        entity.priority = item.priority.rawValue
        entity.dueDate = item.dueDate
        entity.createdAt = item.createdAt
        entity.category = item.category
        save()
    }
    
    func fetchAll() -> [TodoItem] {
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TodoItemEntity.createdAt, ascending: false)]
        
        do {
            let entities = try context.fetch(request)
            return entities.map { TodoItem(from: $0) }
        } catch {
            print("Failed to fetch items: \(error)")
            return []
        }
    }
    
    func update(item: TodoItem) {
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        
        do {
            let entities = try context.fetch(request)
            if let entity = entities.first {
                entity.title = item.title
                entity.todoDescription = item.todoDescription
                entity.isCompleted = item.isCompleted
                entity.priority = item.priority.rawValue
                entity.dueDate = item.dueDate
                entity.category = item.category
                save()
            }
        } catch {
            print("Failed to update item: \(error)")
        }
    }
    
    func delete(item: TodoItem) {
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", item.id as CVarArg)
        
        do {
            let entities = try context.fetch(request)
            if let entity = entities.first {
                context.delete(entity)
                save()
            }
        } catch {
            print("Failed to delete item: \(error)")
        }
    }
    
    func deleteAll() {
        let request: NSFetchRequest<NSFetchRequestResult> = TodoItemEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            save()
        } catch {
            print("Failed to delete all items: \(error)")
        }
    }
}
