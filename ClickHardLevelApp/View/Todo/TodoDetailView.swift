//
//  TodoDetailsView.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI

struct TodoDetailView: View {
    let item: TodoItem
    @ObservedObject var viewModel: TodoViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String
    @State private var description: String
    @State private var priority: TodoItem.Priority
    @State private var dueDate: Date
    @State private var hasDueDate: Bool
    @State private var category: String
    @State private var isCompleted: Bool
    
    init(item: TodoItem, viewModel: TodoViewModel) {
        self.item = item
        self.viewModel = viewModel
        _title = State(initialValue: item.title)
        _description = State(initialValue: item.todoDescription ?? "")
        _priority = State(initialValue: item.priority)
        _dueDate = State(initialValue: item.dueDate ?? Date())
        _hasDueDate = State(initialValue: item.dueDate != nil)
        _category = State(initialValue: item.category ?? "")
        _isCompleted = State(initialValue: item.isCompleted)
    }
    
    var body: some View {
        Form {
            Section("Details") {
                TextField("Title", text: $title)
                TextField("Description", text: $description, axis: .vertical)
                    .lineLimit(3...6)
            }
            
            Section("Priority") {
                Picker("Priority", selection: $priority) {
                    ForEach(TodoItem.Priority.allCases, id: \.self) { priority in
                        HStack {
                            Circle()
                                .fill(priority.color)
                                .frame(width: 12, height: 12)
                            Text(priority.displayName)
                        }
                        .tag(priority)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Due Date") {
                Toggle("Set Due Date", isOn: $hasDueDate)
                
                if hasDueDate {
                    DatePicker("Date", selection: $dueDate, displayedComponents: [.date])
                }
            }
            
            Section("Category") {
                TextField("Category", text: $category)
            }
            
            Section {
                Toggle("Completed", isOn: $isCompleted)
            }
            
            Section {
                Button("Save Changes") {
                    saveChanges()
                }
                .disabled(title.isEmpty)
                
                Button("Delete Task", role: .destructive) {
                    viewModel.delete(item)
                    dismiss()
                }
            }
        }
        .navigationTitle("Edit Task")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveChanges() {
        var updatedItem = item
        updatedItem.title = title
        updatedItem.todoDescription = description.isEmpty ? nil : description
        updatedItem.priority = priority
        updatedItem.dueDate = hasDueDate ? dueDate : nil
        updatedItem.category = category.isEmpty ? nil : category
        updatedItem.isCompleted = isCompleted
        
        viewModel.update(updatedItem)
        dismiss()
    }
}

#Preview {
    TodoDetailView(item: TodoItem(id: UUID(), title: "Test", todoDescription: "fcsdcs dcs dcs dcsd c sdc sdc", isCompleted: true, priority: .high, dueDate: Date(), createdAt: Date(), category: "csdcsdc"), viewModel: TodoViewModel())
}
