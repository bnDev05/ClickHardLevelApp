//
//  TodoViewModel.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import Combine
import SwiftUI

class TodoViewModel: ObservableObject {
    @Published var items: [TodoItem] = []
    @Published var filterOption: FilterOption = .all
    @Published var sortOption: SortOption = .dateCreated
    
    private let coreDataManager = CoreDataManager.shared
    
    enum FilterOption {
        case all, active, completed
    }
    
    enum SortOption {
        case dateCreated, dueDate, priority, title
    }
    
    init() {
        loadItems()
    }
    
    var filteredItems: [TodoItem] {
        let filtered: [TodoItem]
        
        switch filterOption {
        case .all:
            filtered = items
        case .active:
            filtered = items.filter { !$0.isCompleted }
        case .completed:
            filtered = items.filter { $0.isCompleted }
        }
        
        return sortItems(filtered)
    }
    
    private func sortItems(_ items: [TodoItem]) -> [TodoItem] {
        switch sortOption {
        case .dateCreated:
            return items.sorted { $0.createdAt > $1.createdAt }
        case .dueDate:
            return items.sorted {
                guard let date1 = $0.dueDate, let date2 = $1.dueDate else {
                    return $0.dueDate != nil
                }
                return date1 < date2
            }
        case .priority:
            return items.sorted { $0.priority.rawValue > $1.priority.rawValue }
        case .title:
            return items.sorted { $0.title < $1.title }
        }
    }
    
    func loadItems() {
        items = coreDataManager.fetchAll()
    }
    
    func add(title: String, description: String?, priority: TodoItem.Priority,
             dueDate: Date?, category: String?) {
        let item = TodoItem(
            title: title,
            todoDescription: description,
            priority: priority,
            dueDate: dueDate,
            category: category
        )
        coreDataManager.create(item: item)
        loadItems()
    }
    
    func update(_ item: TodoItem) {
        coreDataManager.update(item: item)
        loadItems()
    }
    
    func delete(_ item: TodoItem) {
        coreDataManager.delete(item: item)
        loadItems()
    }
    
    func toggle(_ item: TodoItem) {
        var updatedItem = item
        updatedItem.isCompleted.toggle()
        update(updatedItem)
    }
    
    func deleteAll() {
        coreDataManager.deleteAll()
        loadItems()
    }
}
