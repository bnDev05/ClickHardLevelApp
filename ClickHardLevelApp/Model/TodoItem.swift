//
//  TodoItem.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id: UUID
    var title: String
    var todoDescription: String?
    var isCompleted: Bool
    var priority: Priority
    var dueDate: Date?
    var createdAt: Date
    var category: String?
    
    enum Priority: Int16, CaseIterable {
        case low = 0
        case medium = 1
        case high = 2
        
        var displayName: String {
            switch self {
            case .low: return "Low"
            case .medium: return "Medium"
            case .high: return "High"
            }
        }
        
        var color: Color {
            switch self {
            case .low: return .green
            case .medium: return .orange
            case .high: return .red
            }
        }
    }
    
    init(id: UUID = UUID(), title: String, todoDescription: String? = nil,
         isCompleted: Bool = false, priority: Priority = .medium,
         dueDate: Date? = nil, createdAt: Date = Date(), category: String? = nil) {
        self.id = id
        self.title = title
        self.todoDescription = todoDescription
        self.isCompleted = isCompleted
        self.priority = priority
        self.dueDate = dueDate
        self.createdAt = createdAt
        self.category = category
    }
    
    init(from entity: TodoItemEntity) {
        self.id = entity.id
        self.title = entity.title
        self.todoDescription = entity.todoDescription
        self.isCompleted = entity.isCompleted
        self.priority = Priority(rawValue: entity.priority) ?? .medium
        self.dueDate = entity.dueDate
        self.createdAt = entity.createdAt
        self.category = entity.category
    }
}
