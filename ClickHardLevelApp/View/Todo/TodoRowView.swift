//
//  TodoRowView.swift
//  ClickHardLevelApp
//
//  Created by Behruz Norov on 11/12/25.
//

import SwiftUI

struct TodoRowView: View {
    let item: TodoItem
    @ObservedObject var viewModel: TodoViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: { viewModel.toggle(item) }) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .gray)
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.body)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .gray : .primary)
                
                if let description = item.todoDescription, !description.isEmpty {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                HStack(spacing: 8) {
                    if let dueDate = item.dueDate {
                        Text(dueDate, format: .dateTime.month().day())
                            .font(.caption2)
                            .foregroundColor(dueDate < Date() && !item.isCompleted ? .red : .secondary)
                    }
                    
                    if let category = item.category, !category.isEmpty {
                        Text(category)
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
            }
            
            Spacer()
            
            Circle()
                .fill(item.priority.color)
                .frame(width: 8, height: 8)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TodoRowView(item: TodoItem(id: UUID(), title: "Test", todoDescription: "fcsdcs dcs dcs dcsd c sdc sdc", isCompleted: true, priority: .high, dueDate: Date(), createdAt: Date(), category: "csdcsdc"), viewModel: TodoViewModel())
}
